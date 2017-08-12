'use strict';


module.exports = function ( { toPath, isProd } ) {

  return new ( require( 'favicons-webpack-plugin' ) )( {

    logo: toPath( './source/favicon.png' ),

    emitStats: true,

    prefix: isProd ? 'favicons-[hash]/' : 'favicons/',

    statsFilename: 'favicons.json',

    // title: 'Replace',

  } );

};
