'use strict';


module.exports = function ( { isProd } ) {

  return new ( require( 'extract-text-webpack-plugin' ) )( isProd ? '[name].[contenthash].css' : '[name].css' );

};
