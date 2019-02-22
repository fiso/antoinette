import {BEGIN_REQUEST, END_REQUEST} from './AppActions';

const initialState = {
  requests: {
    pending: [],
    finished: [],
  },
};

export const AppReducer = (state = initialState, action) => {
  switch (action.type) {
    case BEGIN_REQUEST:
      return {
        ...state,
        requests: {
          ...state.requests,
          pending: [
            ...state.requests.pending,
            action.request,
          ],
        },
      };
    case END_REQUEST:
      return {
        ...state,
        requests: {
          ...state.requests,
          pending: state.requests.pending.filter(
              (request) => request.id !== action.request.id),
          finished: [
            ...state.requests.finished,
            action.request,
          ],
        },
      };
    default:
      return state;
  }
};
