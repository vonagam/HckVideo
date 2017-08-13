'use strict';


module.exports = function ( { isDev } ) {

  return new ( require( 'extract-text-webpack-plugin' ) )( {

    filename: '[name].[contenthash].css',

    disable: isDev,

  } );

};
