import React, {PureComponent} from 'react';
import autoBind from 'react-autobind';
import classNames from 'classnames';
import {errorClass} from '~/js/app/components/common/Form';
import Input from '~/js/app/components/common/Input';
import PropTypes from 'prop-types';
import './InputWithLabel.scss';

class InputWithLabel extends PureComponent {
  constructor (props) {
    super(props);
    autoBind(this);
    this.inputRef = React.createRef();
    this.state = {};
  }

  componentDidMount () {
    this.checkForValue();
  }

  set value (value) {
    this.inputRef.current.value = value;
  }

  get value () {
    return this.inputRef.current.value;
  }

  onChange (e) {
    const {onChange} = this.props;
    this.checkForValue();
    if (onChange) {
      onChange(e);
    }
  }

  checkForValue () {
    const {refPassthrough} = this.props;
    const ref = refPassthrough || this.inputRef;
    this.setState({
      hasvalue: ref && ref.current && ref.current.value,
    });
  }

  render () {
    const {errorMessage, label, refPassthrough, children, ...inputProps} =
      this.props;
    const {hasvalue} = this.state;
    const ref = refPassthrough || this.inputRef;
    return <div className={classNames('input-with-label', {
      [errorClass]:
        inputProps.validationErrors &&
        inputProps.validationErrors[inputProps.name],
    })}>
      <label htmlFor={inputProps.id} className={classNames({
        'hidden-if-empty': inputProps.type !== 'select',
        hasvalue,
      })}>{label}</label>
      {children}
      <Input {...inputProps}
        onChange={this.onChange}
        ref={ref}
        placeholder={inputProps.placeholder || label} />
      <small>{errorMessage}</small>
    </div>;
  }
}

export default InputWithLabel;

InputWithLabel.propTypes = {
  children: PropTypes.node,
  errorMessage: PropTypes.string,
  label: PropTypes.string,
  refPassthrough: PropTypes.object,
};

InputWithLabel.defaultProps = {
  children: [],
  errorMessage: '',
};
