import React, {PureComponent} from 'react';
import {validationErrorEvent, validationOkEvent} from './Form';
import autoBind from 'react-autobind';
import './FormView.scss';

function childrenAsArray (children) {
  return children.filter
    ? children
    : [children];
}

export const formViewWrapper = (WrappedComponent, classNames) => {
  return class FormWrapperComponent extends PureComponent {
    constructor (props) {
      super(props);
      autoBind(this);
      this.state = {
        formValues: {},
        validationErrors: {},
      };
      this.formRef = React.createRef();
      this.containerRef = React.createRef();
    }

    onValidationError (event) {
      const name = event.detail.source.name;
      this.setState({
        validationErrors: {
          ...this.state.validationErrors,
          [name]: true,
        },
      });
    }

    onValidationOk (event) {
      const name = event.detail.source.name;
      this.setState({
        validationErrors: {
          ...this.state.validationErrors,
          [name]: false,
        },
      });
    }

    clearValidationErrors () {
      this.setState({validationErrors: {}});
    }

    componentDidMount () {
      if (!this.formRef.current) {
        console.error('FormView - wrapped component did not use formRef!');
        return;
      }

      function findInputs (acc, val) {
        let children = null;

        if (val.props) {
          let inputValue = undefined;
          if (typeof val.props.defaultValue !== 'undefined') {
            inputValue = val.props.defaultValue;
          } else if (typeof val.props.defaultChecked !== 'undefined') {
            if (val.props.type === 'checkbox') {
              inputValue = val.props.defaultChecked;
            } else if (val.props.type === 'radio') {
              if (val.props.defaultChecked) {
                inputValue = val.props.value;
              } else if (typeof acc[val.props.name] === 'undefined') {
                inputValue = null;
              }
            } else {
              console.warn(`Unknown input type ${val.props.type}`);
            }
          } else if (val.props.children &&
            typeof val.props.children !== 'string') {
            children = childrenAsArray(val.props.children);
          }

          if (inputValue !== undefined && !val.props.disabled) {
            acc[val.props.name] = inputValue;
          }
        } else if (val.filter) {
          children = val;
        }

        if (children) {
          acc = {
            ...acc,
            ...children
                .filter(Boolean)
                .reduce(findInputs, {}),
          };
        }

        return acc;
      }

      const formValues = childrenAsArray(this.formRef.current.props.children)
          .filter(Boolean)
          .reduce(findInputs, {});

      this.setState({formValues});

      this.containerRef.current.addEventListener(validationErrorEvent,
          this.onValidationError);
      this.containerRef.current.addEventListener(validationOkEvent,
          this.onValidationOk);
    }

    componentWillUnmount () {
      this.containerRef.current.removeEventListener(validationErrorEvent,
          this.onValidationError);
      this.containerRef.current.removeEventListener(validationOkEvent,
          this.onValidationOk);
    }

    onChange (e) {
      const el = e.target;

      const value = el.type === 'checkbox'
        ? el.checked
        : el.value;

      this.setState({
        formValues: {
          ...this.state.formValues,
          [el.name]: value,
        },
      });
    }

    render () {
      return (
        <div onChange={this.onChange} ref={this.containerRef}
          className={classNames}>
          <WrappedComponent {...this.props}
            clearValidationErrors={this.clearValidationErrors}
            formRef={this.formRef}
            formState={{
              values: this.state.formValues,
              validationErrors: this.state.validationErrors,
            }} />
        </div>
      );
    }
  };
};
