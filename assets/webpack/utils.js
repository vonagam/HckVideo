'use strict';

const path = require( 'path' );

const _ = require( 'lodash' );


module.exports = function ( config ) {

  const toPath = ( value ) => path.resolve( value );


  const env = process.env.NODE_ENV || 'development';

  const isProd = env === 'production';

  const isDev = env === 'development';


  const get = ( key, defaultValue ) => _.get( config, key, defaultValue );

  const set = ( key, value ) => _.set( config, key, value );

  const push = ( key, value ) => {

    let array = get( key, [] );

    set( key, _.concat( array, value ) );

  };

  const assign = ( key, value ) => {

    let object = get( key, {} );

    set( key, _.assign( object, value ) );

  };


  return { toPath, env, isProd, isDev, get, set, push, assign };

};
