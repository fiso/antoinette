export const getHash = () =>
  window.location.hash
    ? Number(window.location.hash.split('#').pop())
    : 0;
