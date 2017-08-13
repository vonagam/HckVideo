import Application from './scripts/application';

import { AppContainer } from 'react-hot-loader';

require( './styles/index.styl' );


let root = undefined;

let props = undefined;

const render = ( Application ) => {

  ReactDOM.render(

    <AppContainer>

      <Application { ...props } />

    </AppContainer>,

    root

  );

};

window.startApplication = ( _root, _props ) => {

  root = $( _root )[ 0 ];

  props = _props;

  render( Application );

};


if ( module.hot ) {

  module.hot.accept( './scripts/application.jsx', () => {

    let Application = require( './scripts/application' ).default;

    render( Application );

  } );

}
