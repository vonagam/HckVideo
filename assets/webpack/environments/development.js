'use strict';

const _ = require( 'lodash' );


module.exports = function ( { toPath, get, set, push } ) {

  const devServer = {

    host: '0.0.0.0',

    port: '8888',

    https: false,

    contentBase: toPath( '../priv/static' ),

    compress: true,

    headers: { 'Access-Control-Allow-Origin': '*' },

    hot: true,

    clientLogLevel: 'none',

    watchOptions: { ignored: /node_modules/ },

  };

  const host = `http${ devServer.https ? 's' : '' }://${ devServer.host }:${ devServer.port }`;


  set( 'devServer', devServer );

  set( 'entry', _.mapValues( get( 'entry' ), ( points ) => {

    return _.concat( [

      'react-hot-loader/patch',

      `webpack-dev-server/client?${ host }`,

      'webpack/hot/only-dev-server',

    ], points );

  } ) );

  set( 'output.publicPath', `${ host }/` );

  push( 'plugins', [

    new ( require( 'webpack' ).HotModuleReplacementPlugin )(),

    new ( require( 'webpack' ).NoEmitOnErrorsPlugin )(),

  ] );

  set( 'devtool', 'cheap-module-eval-source-map' );

  set( 'output.pathinfo', true );

  set( 'stats.errorDetails', true );

};
