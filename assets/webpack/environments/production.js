'use strict';


module.exports = function ( { toPath, get, set, push } ) {

  set( 'output.publicPath', '/assets/' );

  push( 'plugins', [

    new ( require( 'webpack' ).optimize.UglifyJsPlugin )( {

      minimize: true,

      sourceMap: true,

      compress: { warnings: false },

      output: { comments: false },

    } ),

    new ( require( 'clean-webpack-plugin' ) )( [ toPath( '../priv/static/assets' ) ], { root: toPath( '../priv/static' ), verbose: false } ),

    // new ( require( 'copy-webpack-plugin' ) )( [ { from: toPath( './static' ), to: toPath( '../priv/static' ) } ] ),

    new ( require( 'assets-webpack-plugin' ) )( { path: get( 'output.path' ), filename: 'manifest.json' } ),

    new ( require( 'compression-webpack-plugin' ) )(),

  ] );

  set( 'devtool', 'source-map' );

  set( 'stats', 'normal' );

};
