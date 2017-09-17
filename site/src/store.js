import { REHYDRATE } from 'redux-persist/constants';
import createActionBuffer from 'redux-action-buffer';
import { createStore, applyMiddleware } from 'redux';
import { syncHistoryWithStore } from 'react-router-redux';
import { browserHistory } from 'react-router';
import promise from 'redux-promise-middleware';
import { composeWithDevTools } from 'redux-devtools-extension';
import createSagaMiddleware from 'redux-saga';
import { persistStore, autoRehydrate } from 'redux-persist';

import reducer from './reducer';

const sagaMiddleware = createSagaMiddleware();

const middleware = applyMiddleware(promise(), sagaMiddleware);

const store = createStore(reducer, {}, composeWithDevTools(middleware, autoRehydrate(), applyMiddleware(createActionBuffer(REHYDRATE))));

export var persistedStore = persistStore(store);
export const purgeStore = () => persistedStore.purge();

const saga = function*() {
  yield [];
};

sagaMiddleware.run(saga);

export const history = syncHistoryWithStore(browserHistory, store);

export default store;
