import _ from 'lodash';

import { Card, Form, Select, DatePicker, Button } from 'antd';

import moment from 'moment';


let OPTIONS;

let DATES;

let DEFAULT_FILTERS;


class PhxSelect extends React.Component {

  render() {

    return (

      <Select

        { ...this.props }

        mode='multiple'

        filterOption={ ( value, option ) => ~option.props.children.indexOf( value ) }

        children={ _.map( this.props.children, ( [ value, label ] ) =>

          <Select.Option key={ value } value={ value + '' } children={ label } />

        ) }

      />

    );

  }

}


class PhxSiderForm extends React.Component {

  constructor( props ) {

    super( props );

    this.state = {

      loading: false,

      filtered: window.location.search !== '',

    };

  }

  onSubmit = ( event ) => {

    event.preventDefault();

    if ( this.state.loading ) return;

    this.props.form.validateFields( ( error, filters ) => {

      let params = {};

      if ( filters.date !== DATES && ! _.isEmpty( filters.date ) ) {

        params.date = { min: filters.date[ 0 ].toISOString(), max: filters.date[ 0 ].toISOString() }

      }

      params.subjects = _.pickBy( _.omit( filters, 'date' ) );

      this.setState( {

        loading: true,

        filtered: _.some( [ 'date', 'subjects' ], ( key ) => ! _.isEmpty( params[ key ] ) ),

      } );

      $.ajax( {

        method: 'get',

        url: '/',

        data: params,

        headers: { Accept: 'application/json' },

        complete: () => { this.setState( { loading: false } ) },

        error: () => { alert( 'error... :(' ) },

        success: ( { view } ) => {

          if ( _.isEmpty( view.videos ) ) {

            alert( 'видео не нашлось :(' )

          }

          this.props.onSuccess( view );

        },

      } )

    } );

  }

  onClear = () => {

    this.props.form.resetFields();

    this.setState( { filtered: false } );

  }

  render() {

    let { getFieldDecorator } = this.props.form;


    return (

      <Form

        layout='vertical'

        onSubmit={ this.onSubmit }

      >

        <Form.Item label='Города'>

          {

            getFieldDecorator( 'cities', {} )(

              <PhxSelect children={ OPTIONS.cities } />

            )

          }

        </Form.Item>

        <Form.Item label='Группы'>

          {

            getFieldDecorator( 'groups', {} )(

              <PhxSelect children={ OPTIONS.groups } />

            )

          }

        </Form.Item>

        <Form.Item label='Личности'>

          {

            getFieldDecorator( 'persons', {} )(

              <PhxSelect children={ OPTIONS.persons } />

            )

          }

        </Form.Item>

        <Form.Item label='Типы'>

          {

            getFieldDecorator( 'types', {} )(

              <PhxSelect children={ OPTIONS.types } />

            )

          }

        </Form.Item>

        <Form.Item label='Дата'>

          {

            getFieldDecorator( 'date', { initialValue: DATES } )(

              <DatePicker.RangePicker

                showTime={ { format: 'HH:mm' } }

                format='DD-MM-YYYY HH:mm'

                placeholder={ [ 'От', 'До' ] }

                style={ { width: '100%' } }

                ranges={ { 'Все': DATES } }

              />

            )

          }

        </Form.Item>

        <Form.Item>

          <Button

            loading={ this.state.loading }

            type='primary'

            htmlType='submit'

            icon='search'

            style={ { width: '100%' } }

            children='Применить фильтры'

          />

          <Button

            disabled={ ! this.state.filtered }

            size='default'

            icon='close'

            style={ { width: '100%' } }

            onClick={ this.onClear }

            children='Очистить фильтры'

          />

          <Button

            size='default'

            icon='plus'

            style={ { width: '100%' } }

            children='Добавить видео'

          />

        </Form.Item>

      </Form>

    );

  }

};

const PhxSiderFormWrapped = Form.create()( PhxSiderForm );


export default class PhxSider extends React.Component {

  constructor( props ) {

    super( props );

    OPTIONS = props.options;

    DATES = [ moment( OPTIONS.date[ 0 ] ), moment( OPTIONS.date[ 1 ] ) ];

    DEFAULT_FILTERS = { date: DATES, cities: undefined, groups: undefined, persons: undefined, types: undefined };

  }

  setFilters = ( filters ) => {

    filters = _.defaults( {}, filters, DEFAULT_FILTERS );

    this.refs.form.setFields( _.mapValues( filters, ( value ) => {

      return { value };

    } ) );

  }

  render() {

    return (

      <Card title='Фильтры'>

        <PhxSiderFormWrapped ref='form' onSuccess={ this.props.onFilter } />

      </Card>

    );

  }

}
