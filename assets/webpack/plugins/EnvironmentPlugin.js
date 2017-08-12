'use strict';


module.exports = function ( { env } ) {

  return new ( require( 'webpack' ).EnvironmentPlugin )( {

    'NODE_ENV': JSON.stringify( env ),

  } );

};
