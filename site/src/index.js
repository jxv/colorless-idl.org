import React from 'react';
import ReactDOM from 'react-dom';
import { Router, Route } from 'react-router';
import { Provider } from 'react-redux';

import store, { history } from  './store';
import './index.css';
import Root from './scenes/Root';

const router =
  <Provider store={store}>
    <Router history={history}>
      <Route path="/" component={Root} />
    </Router>
  </Provider>;

ReactDOM.render(router, document.getElementById('root'));
