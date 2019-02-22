export function attachSwipeEvents (root) {
  root.addEventListener('touchstart', handleTouchStart, {passive: true});
  root.addEventListener('touchmove', handleTouchMove, {passive: true});
  root.addEventListener('touchend', handleTouchEnd, {passive: true});
}

let xDown = null;
let yDown = null;
let targetElement = null;
let swallowNextTouchEnd = false;

function handleTouchStart (evt) {
  xDown = evt.touches[0].clientX;
  yDown = evt.touches[0].clientY;
  targetElement = evt.target;
}

function handleTouchEnd (evt) {
  if (swallowNextTouchEnd) {
    evt.stopPropagation();
    swallowNextTouchEnd = false;
  }
}

function dispatchSwipe (targetElement, eventName) {
  targetElement.dispatchEvent(new CustomEvent(eventName, {bubbles: true}));
  swallowNextTouchEnd = true;
  xDown = null;
  yDown = null;
  targetElement = null;
}

function handleTouchMove (evt) {
  if (!xDown || !yDown) {
    return;
  }

  const xNow = evt.touches[0].clientX;
  const yNow = evt.touches[0].clientY;
  const xDiff = xDown - xNow;
  const yDiff = yDown - yNow;
  const threshold = 1;

  if (Math.abs(xDiff) > Math.abs(yDiff)) {
    if (xDiff > threshold) {
      dispatchSwipe(targetElement, 'swipeleft');
    } else if (xDiff < -threshold) {
      dispatchSwipe(targetElement, 'swiperight');
    }
  } else {
    if (yDiff > threshold) {
      dispatchSwipe(targetElement, 'swipeup');
    } else if (yDiff < -threshold) {
      dispatchSwipe(targetElement, 'swipedown');
    }
  }
}
