import Input from '~/js/app/components/common/Input';
import PropTypes from 'prop-types';
import React from 'react';
import './RadioGroup.scss';

const RadioGroup = React.memo(({choices, defaultValue, legend, name,
  validationErrors}) =>
  <fieldset className='radiogroup'>
    <legend>{legend}</legend>
    <div className='two-col'>
      {choices.map((choice, i) => {
        const {label, value} = typeof choice === 'string'
          ? {label: choice, value: String(i)}
          : choice;
        return <Input id={`${name}-${i}`} name={name} type='radio' key={i}
          label={label} defaultChecked={value === String(defaultValue)}
          value={value} required validationErrors={validationErrors} />;
      }
      )}
    </div>
  </fieldset>
);

export default RadioGroup;

RadioGroup.propTypes = {
  choices: PropTypes.array,
  defaultValue: PropTypes.string,
  legend: PropTypes.string,
  name: PropTypes.string,
  validationErrors: PropTypes.object,
};
