import React, {PureComponent} from 'react';
import autoBind from 'react-autobind';
import classNames from 'classnames';
import PropTypes from 'prop-types';
import ReactDOM from 'react-dom';
import './Form.scss';

export const validationErrorEvent = 'validationError';
export const validationOkEvent = 'validationOk';
export const errorClass = 'validation-error';

function validationError (source) {
  return new CustomEvent(validationErrorEvent, {
    bubbles: true,
    detail: {
      source,
    },
  });
}

function validationOk (source) {
  return new CustomEvent(validationOkEvent, {
    bubbles: true,
    detail: {
      source,
    },
  });
}

export default class Form extends PureComponent {
  constructor (props) {
    super(props);
    autoBind(this);
    this.formRef = React.createRef();
  }

  submit () {
    this.formRef.current.dispatchEvent(new Event('submit'));
  }

  onSubmit (event) {
    if (!this.props.allowPropagation) {
      event.preventDefault();
      event.stopPropagation();
    }

    if (!this.isValid()) {
      this.showValidationErrors();
      return false;
    }

    if (this.props.onSubmit) {
      this.props.onSubmit(event);
    }

    return true;
  }

  get element () {
    return ReactDOM.findDOMNode(this); // eslint-disable-line react/no-find-dom-node
  }

  showValidationErrors () {
    const inputs = document.querySelectorAll('form *[required]');
    for (const input of inputs) {
      if (!input.checkValidity()) {
        setTimeout(() => input.dispatchEvent(validationError(input)), 0);
      } else {
        setTimeout(() => input.dispatchEvent(validationOk(input)), 0);
      }
    }

    const fieldSets = document.querySelectorAll('form fieldset');
    for (const fieldSet of fieldSets) {
      if (!fieldSet.dataset.minSelectionCount) {
        continue;
      }

      const min = Number(fieldSet.dataset.minSelectionCount);
      const nSelected = fieldSet.querySelectorAll(':checked').length;

      if (nSelected < min) {
        setTimeout(() => fieldSet.dispatchEvent(validationError(fieldSet)), 0);
      } else {
        setTimeout(() => fieldSet.dispatchEvent(validationOk(fieldSet)), 0);
      }
    }
  }

  onChange (event) {
    const el = event.target;

    if (el.required && el.checkValidity()) {
      el.dispatchEvent(validationOk(el));
    }

    const fset = el.closest('fieldset[data-min-selection-count]');
    if (fset) {
      const min = Number(fset.dataset.minSelectionCount);
      const nSelected = fset.querySelectorAll(':checked').length;
      if (nSelected >= min) {
        setTimeout(() => fset.dispatchEvent(validationOk(fset)), 0);
      }
    }

    if (this.props.onChange) {
      this.props.onChange(event);
    }
  }

  isValid () {
    let fieldsetsValid = true;
    const fieldSets = document.querySelectorAll('form fieldset');
    for (const fieldSet of fieldSets) {
      if (!fieldSet.dataset.minSelectionCount) {
        continue;
      }

      const min = Number(fieldSet.dataset.minSelectionCount);
      const nSelected = fieldSet.querySelectorAll(':checked').length;

      if (nSelected < min) {
        fieldsetsValid = false;
      } else {
        setTimeout(() => fieldSet.dispatchEvent(validationOk(fieldSet)), 0);
      }
    }

    return fieldsetsValid && this.formRef.current.checkValidity();
  }

  render () {
    const {disabled, children, allowPropagation: _, className, ...props} =
      this.props;

    /*
      FIXME: To produce more semantically correct markup, we should pass down
      the 'disabled' prop to all children that are input elements. This code
      needs to be modified to take into consideration that not all inputs
      are necessarily direct children.
    */
    /*
    const childrenWithProps = React.Children.map(children, child =>
      React.cloneElement(child, {disabled}));
    */

    return (
      <form {...props} ref={this.formRef}
        noValidate
        onSubmit={this.onSubmit}
        onChange={this.onChange}
        className={classNames(className, {
          disabled,
        })}
        disabled={disabled}>
        {children}
      </form>
    );
  }
}

Form.propTypes = {
  allowPropagation: PropTypes.bool,
  children: PropTypes.node,
  className: PropTypes.string,
  disabled: PropTypes.bool,
  onChange: PropTypes.func,
  onSubmit: PropTypes.func,
};

Form.defaultProps = {
  children: [],
  className: '',
};
