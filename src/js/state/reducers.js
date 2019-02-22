import {AppReducer} from './AppReducer';
import {combineReducers} from 'redux';
import {OptionsReducer} from './OptionsReducer';
import {PageReducer} from './PageReducer';

export const rootReducer = combineReducers({
  app: AppReducer,
  options: OptionsReducer,
  page: PageReducer,
});
