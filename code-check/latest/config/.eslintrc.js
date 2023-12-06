module.exports = {
  root: true,
  env: {
    'browser': true,
    'es2017': true,
    'node': true
  },
  extends: [
  ],
  'parser': '/usr/local/lib/node_modules/vue-eslint-parser',
  parserOptions: {
    sourceType: 'module',
    ecmaVersion: 2020,
  },
  plugins: [
    'vue',
  ],
  ignorePatterns: [

  ],
  globals : {
    'Vue': false,
    '$': true,
    '_': true,
    'trans': true,
    'Bus': true,
    'axios': true
  },
  rules: {
    'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-new': 0,
    'quotes': ['error','single'], // enforce the consistent use of either single quotes
    'comma-dangle': ['error', 'never'], // require or disallow trailing commas
    'semi': ['error', 'never'], // disallow semicolons instead of ASI,
    'no-shadow-restricted-names': 'off', // Allow undefined or unknown variables
    'no-import-assign': 'off', // ts(2539) & ts(2540)
    'no-setter-return': 'off', // ts(2408)
    'no-var': 0, // ts transpiles let/const to var, so no need for vars any more
    'prefer-const': 'error', // ts provides better types with const
    'prefer-rest-params': 'off', // ts provides better types with rest args over arguments
    'prefer-spread': 'error', // ts transpiles spread to apply, so no need for manual apply
    'constructor-super': 'error',
    'for-direction': 'error',
    'getter-return': 'error',
    'no-async-promise-executor': 'error',
    'no-case-declarations': 'error',
    'no-class-assign': 'error',
    'no-compare-neg-zero': 'error',
    'no-cond-assign': 'error',
    'no-const-assign': 'error',
    'no-constant-condition': 'error',
    'no-control-regex': 'error',
    'no-delete-var': 'error',
    'no-dupe-args': 'error',
    'no-dupe-class-members': 'error',
    'no-dupe-keys': 'error',
    'no-duplicate-case': 'error',
    'no-empty': 'error',
    'no-empty-character-class': 'error',
    'no-empty-pattern': 'error',
    'no-ex-assign': 'error',
    'no-extra-boolean-cast': 'error',
    'no-extra-semi': 'error',
    'no-fallthrough': 'error',
    'no-func-assign': 'error',
    'no-global-assign': 'error',
    'no-inner-declarations': 'error',
    'no-invalid-regexp': 'error',
    'no-irregular-whitespace': 'error',
    'no-misleading-character-class': 'error',
    'no-mixed-spaces-and-tabs': 'error',
    'no-new-symbol': 'error',
    'no-obj-calls': 'error',
    'no-octal': 'error',
    'no-prototype-builtins': 'error',
    'no-redeclare': 'error',
    'no-regex-spaces': 'error',
    'no-self-assign': 'error',
    'no-sparse-arrays': 'error',
    'no-this-before-super': 'error',
    'no-undef': 'error',
    'no-unexpected-multiline': 'error',
    'no-unreachable': 'error',
    'no-unsafe-finally': 'error',
    'no-unsafe-negation': 'error',
    'no-unused-labels': 'error',
    'no-useless-catch': 'error',
    'no-useless-escape': 'error',
    'no-with': 'error',
    'require-yield': 'error',
    'use-isnan': 'error',
    'no-unused-vars': 'off',
  },
};

