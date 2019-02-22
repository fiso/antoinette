if (!window.requestIdleCallback) {
  window.requestIdleCallback = function (fn) {
    return setTimeout(fn, 500); // 🤷🏽‍
  };

  window.cancelIdleCallback = function (id) {
    return clearTimeout(id);
  };
}
