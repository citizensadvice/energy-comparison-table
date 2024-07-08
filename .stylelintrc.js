module.exports = {
  extends: ['stylelint-config-standard-scss'],
  plugins: ['stylelint-selector-bem-pattern'],
  rules: {
    // Disallow named colours, for colours we use sass variables
    'color-named': 'never',

    // Set a reasonable limit on how many compound selectors we can have
    'selector-max-compound-selectors': 4,

    // Don't allow styling of IDs
    'selector-max-id': 0,

    // Disable unwanted or conflicting selector patterns
    'selector-class-pattern': null,
    'selector-id-pattern': null,

    // Prefer legacy colour function notation
    'color-function-notation': 'legacy',
    'alpha-value-notation': 'number',

    // We provide a cads-transition-animation mixin for handling
    // transitions along with a prefers-reduced-motion fallback,
    // so disallow this property when used without this mixin.
    'property-disallowed-list': ['transition'],

    // Ensure that all font-stacks have a generic fallback,
    // with the exception of the cads icon font.
    'font-family-no-missing-generic-family-keyword': [
      true,
      { ignoreFontFamilies: ['/cads/'] },
    ],

    // Default at-rule conflicts with scss features,
    // replace with stylelint-scss version
    'at-rule-no-unknown': null,
    'at-rule-disallowed-list': ['debug'],
    'scss/at-rule-no-unknown': true,

    // Disable kebab-case preference for variable names
    // Current design system variables names use a more complex format
    // which will eventually be simplified
    // See https://github.com/citizensadvice/design-system/pull/1863
    'scss/dollar-variable-pattern': null,

    // Additional stylelint-scss rules
    'scss/selector-no-redundant-nesting-selector': true,
    'scss/load-no-partial-leading-underscore': true,
    'scss/at-extend-no-missing-placeholder': true,

    // Configure BEM pattern
    // Note: requires components to have an explicit @define comment
    // e.g. breadcrumb would use /** @define breadcrumb */
    'plugin/selector-bem-pattern': {
      preset: 'bem',
    },

    'media-feature-range-notation': 'prefix',

    // @FIXME
    'scss/no-global-function-names': null,
  },
};