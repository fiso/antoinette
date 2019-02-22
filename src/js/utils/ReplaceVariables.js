export const replaceVariables = (str, vars = {}) =>
  Object.keys(vars).reduce(
      (str, varName) =>
        str.replace(
            new RegExp('\\$\\{' + String(varName) + '\\}', 'g'),
            vars[varName]),
      str);
