import {applyMiddleware, createStore} from 'redux';
import {loadState, saveState} from '~/js/state/LocalStorage';
import App from '~/js/app/App';
import {attachSwipeEvents} from '~/js/utils/SwipeEvents';
import {BrowserRouter} from 'react-router-dom';
import {initializeGoogleAnalytics} from '~/js/utils/Analytics';
import {Provider} from 'react-redux';
import React from 'react';
import ReactDOM from 'react-dom';
import {rootReducer} from '~/js/state/reducers';
import smoothscroll from 'smoothscroll-polyfill';
import thunkMiddleware from 'redux-thunk';
import '~/js/utils/RequestIdleCallbackPolyfill';

smoothscroll.polyfill();
attachSwipeEvents(document);

String.prototype.replaceAll = function (search, replacement) {
  return this.replace(new RegExp(search, 'g'), replacement);
};

export const store = createStore(rootReducer,
    loadState(window.__INITIAL_STATE__),
    applyMiddleware(thunkMiddleware));

store.subscribe(() => {
  saveState(store.getState());
});

window.store = store;

ReactDOM.render(
    <Provider store={store}>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </Provider>,
    document.getElementById('react-root')
);

if (store.getState().options.google_analytics_id) {
  requestIdleCallback(() => {
    initializeGoogleAnalytics(store.getState().options.google_analytics_id);
  });
}
