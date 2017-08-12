'use strict';


module.exports = function () {

  return new ( require( 'webpack' ).ProvidePlugin )( {

    '$': 'jquery',

    'React': 'react',

    'ReactDOM': 'react-dom',

    'Routes': '~/routes',

  } );

};
