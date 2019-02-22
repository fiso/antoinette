import React, {PureComponent} from 'react';
import assert from 'assert';
import autoBind from 'react-autobind';
import classNames from 'classnames';
import {errorClass} from '~/js/app/components/common/Form';
import PropTypes from 'prop-types';
import './Input.scss';

export default class Input extends PureComponent {
  constructor (props) {
    super(props);
    autoBind(this);
    this.inputRef = React.createRef();
  }

  clear () {
    this.inputRef.current.value = '';
  }

  focus () {
    this.inputRef.current.focus();
  }

  set value (value) {
    this.inputRef.current.value = value;
  }

  get value () {
    return this.inputRef.current.value;
  }

  render () {
    const {
      choices,
      label,
      placeholder,
      type,
      validationErrors,
      ...props} = this.props;

    const validationError = validationErrors
      ? validationErrors[props.name]
      : false;

    if (type === 'select') {
      const showPlaceholder = placeholder
        ? !props.defaultValue
        : false;
      assert(choices.length > 0);

      return (
        <div className={classNames('input-wrapper', type, {
          [errorClass]: validationError,
        })}>
          <select {...props} ref={this.inputRef}
            defaultValue={props.defaultValue || ''}>
            {showPlaceholder &&
              <option disabled hidden value=''>
                {placeholder}
              </option>
            }
            {choices.map((choice, i) =>
              <option key={i} value={choice.value || choice.text}>
                {choice.text || choice.value}
              </option>
            )}
          </select>
        </div>
      );
    } else if (['checkbox', 'radio'].some(e => e === type)) {
      return (
        <label className={classNames('input-wrapper', type, {
          [errorClass]: validationError,
        })}>
          <input {...props} ref={this.inputRef} type={type} />
          <span className='label'>{label}</span>
        </label>
      );
    } else if (type === 'multiline') {
      return <textarea {...props} ref={this.inputRef} placeholder={placeholder}
        className={classNames({[errorClass]: validationError})}>
      </textarea>;
    } else {
      return <input {...props} type={type} ref={this.inputRef}
        placeholder={placeholder}
        className={classNames({[errorClass]: validationError})} />;
    }
  }
}

Input.propTypes = {
  choices: PropTypes.array,
  defaultValue: PropTypes.string,
  label: PropTypes.string,
  name: PropTypes.string,
  placeholder: PropTypes.string,
  type: PropTypes.string,
  validationErrors: PropTypes.object,
};

Input.defaultProps = {
  type: 'text',
};
