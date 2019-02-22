import {clearCookie, getCookie} from '~/js/utils/Cookie';
import {version as appVersion} from '~/../package.json';
import {config} from '~/js/Config';
import {setAuthToken} from '~/js/utils/BackendRequest';

const storageKey = 'akademi-state';

const dontPersist = [
  'page', 'options',
];

const filterObject = (obj, filter) =>
  Object.keys(obj)
      .filter(key => !filter.some(el => el === key))
      .reduce((acc, val) => {
        acc[val] = obj[val];
        return acc;
      }, {})
;

export function saveState (state) {
  localStorage.setItem(storageKey, JSON.stringify({
    state: filterObject(state, dontPersist),
    version: appVersion,
  }));
}

export function loadState (baseState) {
  try {
    const {version, state} = {
      ...JSON.parse(localStorage.getItem(storageKey)) || {},
    };

    if (version) {
      console.info(`Found state from version ${version}`);

      if (version !== appVersion) {
        console.info(`State version mismatch (expected ${appVersion}) 👎`);
        localStorage.removeItem(storageKey);
        return baseState;
      } else {
        console.info('State version matches 👌');
      }
    }

    const userFromCookie = getCookie(config.userCookie);
    if (userFromCookie) {
      clearCookie(config.userCookie);
    }

    const signatureFromCookie = getCookie(config.signatureCookie);
    if (signatureFromCookie) {
      clearCookie(config.signatureCookie);
    }

    const mergedState = {
      ...state,
      ...baseState,
      ...userFromCookie
        ? {user: JSON.parse(decodeURIComponent(userFromCookie)).payload.user}
        : {},
      ...signatureFromCookie
        ? {signatures: [JSON.parse(decodeURIComponent(
            signatureFromCookie)).payload.signature]}
        : {},
    };

    if (mergedState.user && mergedState.user.token) {
      setAuthToken(mergedState.user.token);
    }

    return mergedState;
  } catch (e) {
    console.error(e);
    return baseState;
  }
}
