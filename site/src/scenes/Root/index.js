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
		Fluid, stuff coming soon.
        </div>
      </div>
    );
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Root);
