export function isError (code) {
  return code > 399;
}

export function isSuccess (code) {
  return code > 199 && code < 300;
}
