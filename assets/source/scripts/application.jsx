import _ from 'lodash';

import { LocaleProvider, Row, Col } from 'antd';

import ruRU from 'antd/lib/locale-provider/ru_RU';

import PhxSider from './sider';

import PhxHeader from './header';

import PhxContent from './content';


const searchToFilters = ( search ) => {

  let filters = {};

  if ( search.date ) {

    filters.date = [ search.date.min, search.date.max ];

  }

  _.assign( filters, _.mapValues( search.subjects, ( ids ) =>

    _.map( ids, ( id ) => id.toString() )

  ) );

  return filters;

};


export default class Application extends React.Component {

  constructor( props ) {

    super( props );

    this.state = {

      view: props.data.view,

    };

    window.history.replaceState( { view: this.state.view }, undefined );

    $( window ).on( 'popstate', ( event ) => {

      let view = _.get( event, 'originalEvent.state.view' );

      if ( ! view ) return;

      this.setState( { view } );

      let filters = searchToFilters( view.search );

      this.refs.sider.setFilters( filters );

    } );

  }

  componentDidMount() {

    let filters = searchToFilters( this.state.view.search );

    this.refs.sider.setFilters( filters );

  }

  onFilter = ( view ) => {

    let a = window.document.createElement( 'a' );

    a.href = window.location.href;

    a.search = $.param( view.search );

    window.history.pushState( { view }, undefined, a.href );

    this.setState( { view } );

  }

  render() {

    return (

      <LocaleProvider locale={ ruRU }>

        <div>

          <PhxHeader subject={ this.state.view.subject } />

          <Row gutter={ 16 }>

            <Col span={ 8 } md={ 6 } xl={ 4 }><PhxSider ref='sider' options={ this.props.options } onFilter={ this.onFilter } /></Col>

            <Col span={ 16 } md={ 18 } xl={ 20 }><PhxContent view={ this.state.view } /></Col>

          </Row>

        </div>

      </LocaleProvider>

    );

  }

}
