'use strict';

const { sync } = require( 'glob' );

const _ = require( 'lodash' );


const config = {};

const utils = require( './utils' )( config );

const { toPath, env, isProd, get, set, push } = utils;


set( 'context', toPath( './source' ) );

set( 'entry', { application: [ toPath( './source/index' ) ] } );

set( 'output.filename', isProd ? '[name].[chunkhash].js' : '[name].js' );

set( 'output.path', toPath( '../priv/static/assets' ) );

push( 'module.rules', _.map( sync( toPath( './webpack/rules/*.js' ) ), ( path ) => require( path )( utils ) ) );

set( 'resolve.alias', { '~': get( 'context' ) } );

set( 'resolve.extensions', [ '.js', '.json', '.jsx' ] );

push( 'plugins', _.map( sync( toPath( './webpack/plugins/*.js' ) ), ( path ) => require( path )( utils ) ) );


require( `./environments/${ env }` )( utils );


module.exports = config;
