export function getMicrosoftBrowserClasses () {
  const ua = window.navigator.userAgent;
  const msie = ua.indexOf('MSIE ') > 0;
  const trident = ua.indexOf('Trident/') > 0;
  const edge = ua.indexOf('Edge/') > 0;

  if (msie) {
    return 'browser-ie browser-ie-pre-11';
  } else if (trident) {
    return 'browser-ie browser-ie-11';
  } else if (edge) {
    return 'browser-edge';
  }

  // The return value needs to be a non-empty string
  return 'browser';
}

export function seemsLikeMobile () {
  // NOTE: This is obviously not going to be 100%, but it should be pretty
  // close as of 2018-10-10. Mozilla recommends this method, FWIW.
  return /Mobi/.test(navigator.userAgent);
}
