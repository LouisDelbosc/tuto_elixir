import {IndexRoute, Route} from 'reqct-router';
import React from 'react';
import MainLayout from '../layouts/main';
import RegistrationsNew from '../views/regristrations/new';

export default (
  <Route component={MainLayout}>
    <Route path='/' component={RegistrationsNew}/>
  </Route>
);
