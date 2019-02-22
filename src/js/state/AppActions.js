export const BEGIN_REQUEST = 'BEGIN_REQUEST';
export function beginRequest (request) {
  return {
    type: BEGIN_REQUEST,
    request,
  };
}

export const END_REQUEST = 'END_REQUEST';
export function endRequest (request) {
  return {
    type: END_REQUEST,
    request,
  };
}
