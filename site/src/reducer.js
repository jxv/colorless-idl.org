import R from 'ramda';
import { combineReducers } from 'redux';
import { handleActions } from 'redux-actions';
import { routerReducer as routing } from 'react-router-redux';

const colorlessIdl = handleActions({
}, {});

const reducer = combineReducers({
  routing,
  colorlessIdl,
});

export default reducer;
