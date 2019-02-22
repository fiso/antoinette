import React, {PureComponent} from 'react';
import autoBind from 'react-autobind';
import {connect} from 'react-redux';
import Example from '~/js/app/components/sections/Example';
import FourOhFour from './404';
import PropTypes from 'prop-types';
import {snakeToCamelObject} from '~/js/utils/SnakeToCamel';
import './App.scss';

const components = {
  example: Example,
};

class App extends PureComponent {
  constructor (props) {
    super(props);
    autoBind(this);
    this.state = {};
  }

  renderFlexibleContent (sections) {
    return sections.map((section, i) => {
      if (!section.acf_fc_layout) {
        console.warn('Warning: section missing acf_fc_layout field');
        return null;
      }
      // Note that this variable name (Component) MUST start with a capital
      // letter, or React will not understand what we're trying to do when
      // we try to render it using JSX further down (the return statement)
      const Component = components[section.acf_fc_layout];
      if (!Component) {
        console.warn(
            `Warning: section specified an undefined component "${
              section.acf_fc_layout
            }"`
        );
        return null;
      }

      const children = section.sections
        ? this.renderFlexibleContent(section.sections)
        : null;

      const props = {
        ...snakeToCamelObject(section),
        onError: this.onError,
        showLoginUi: this.onClickLogin,
      };
      return (
        <Component {...props} key={i}>
          {children}
        </Component>
      );
    });
  }

  render () {
    const {page} = this.props;

    return (
      <React.Fragment>
        <main>
          {page.is404 ?
            <FourOhFour />
           :
            this.renderFlexibleContent(page.sections || [])
          }
        </main>
      </React.Fragment>
    );
  }
}

App.propTypes = {
  page: PropTypes.object.isRequired,
};

const mapStateToProps = state => ({
  page: state.page,
});

const mapDispatchToProps = () => ({});

export default connect(
    mapStateToProps,
    mapDispatchToProps
)(App);
