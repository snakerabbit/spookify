import React from 'react';
import { Route, Link } from 'react-router-dom';
import SessionFormContainer from './session_form/session_form_container';

const App = () => (
  <div>
    <h1>Spookify</h1>
    <Route path='/login' component={SessionFormContainer}></Route>
    <Route path='/signup' component={SessionFormContainer}></Route>
  </div>
);

export default App;
