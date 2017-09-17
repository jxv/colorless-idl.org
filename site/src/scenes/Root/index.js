import R from 'ramda';
import { connect } from 'react-redux';
import React, { Component } from 'react';

const mapStateToProps = state => ({});

const mapDispatchToProps = dispatch => ({});

class Root extends Component {
  componentDidMount() {
    const href = window.location.href;
    const origin = window.location.origin;
    if (origin === 'http://www.colorless-idl.org') {
      window.location = 'https://www.colorless-idl.org' + R.drop(origin.length, href);
    }
  }
  render() {
    return (
      <div className="App">
        <div style={{padding: '30px'}}>
          <img src='https://raw.githubusercontent.com/jxv/colorless-data/master/colorless-logo-sidebar.png' width='176' height='77'/>
        </div>
      </div>
    );
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Root);
