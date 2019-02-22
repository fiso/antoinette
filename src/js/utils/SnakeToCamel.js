export function snakeToCamel (str) {
  return str.replace(/(_\w)/g, (m) => m[1].toUpperCase());
}

export function snakeToCamelObject (object) {
  return Object.keys(object).reduce((acc, val) => {
    acc[snakeToCamel(val)] = object[val];
    return acc;
  }, {});
}
