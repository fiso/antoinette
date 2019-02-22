import {beginRequest, endRequest} from '~/js/state/AppActions';
import {isSuccess} from '~/js/utils/HttpUtils';
import {store} from '~/js/index';

let authToken = null;

export function setAuthToken (token) {
  authToken = token;
}

let requestId = 1;

class RequestError extends Error {
  constructor ({status, message}) {
    super();
    if (Error.captureStackTrace) {
      Error.captureStackTrace(this, RequestError);
    }
    this.status = status;
    this.message = message;
  }

  toString () {
    return this.message;
  }
}

export async function backendRequest (endpoint,
    {method = 'POST', body, auth = true, asFormData = false, queryParams}
    = {}) {
  auth = Boolean(auth);
  const request = {
    id: requestId++,
    endpoint,
    started: Date.now(),
  };
  store.dispatch(beginRequest(request));
  try {
    const result = await fetch(queryParams
      ? `${endpoint}?${Object.keys(queryParams).map(
          (p, n) => `${n > 0 ? '&' : ''}${encodeURIComponent(p)}=${
            encodeURIComponent(queryParams[p])}`
      )}`
      : endpoint, {
      method,
      headers: {
        ...!asFormData && {'Content-Type': 'application/json'},
        ...auth && {'Authorization': `Bearer ${authToken}`},
      },
      ...Boolean(body) && {body:
          asFormData
          ? (() => {
            const formData = new FormData();
            for (const key of Object.keys(body)) {
              formData.append(key, body[key]);
            }
            return formData;
          })()
          : JSON.stringify(body),
      },
    });

    request.status = result.status;

    if (!isSuccess(result.status)) {
      if (auth && result.status === 401) {
        console.info('An authenticated request returned http 401, assuming user token has expired');
      }
      throw new RequestError({
        status: result.status,
        message: `HTTP ${result.status} — ${result.statusText}`,
      });
    }

    return (async () => {
      try {
        return await result.clone().json();
      } catch (e) {
        return await result.text();
      }
    })();
  } catch (err) {
    request.status = err.status || -1;
    throw err;
  } finally {
    request.finished = Date.now();
    request.duration = request.finished - request.started;
    store.dispatch(endRequest(request));
  }
}
