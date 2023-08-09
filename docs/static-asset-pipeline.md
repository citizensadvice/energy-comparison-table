# Static Asset Pipeline

## SCSS/CSS

### Bundling

This app uses [cssbundling](https://github.com/rails/cssbundling-rails) to compile SCSS in `app/assets/stylesheets`. The entry points are defined in `package.json`.

You can start a SCSS compilation watch process with

```
yarn build:css --watch
```

This will watch for changes to `.scss` files and re-compile the CSS automatically. Currently, there is no hot-reloading function.

### Linting

SCSS should follow [BEM (block, element, modifier)](https://getbem.com/) principles and stylelint has been setup to enforce this. There are lots of examples of BEM in both the [design system](https://github.com/citizensadvice/design-system) and [public website](https://github.com/citizensadvice/public-website) code bases.

You can run the css linting with

```
yarn lint:css
```

### View components

[Read more about view components](./view-components.md).

You can see the view components set up in this project by visiting [http://localhost:3000/components/previews](http://localhost:3000/components/previews).

## Javascript

### Bundling

This app uses [jsbundling](https://github.com/rails/jsbundling-rails) to transpile js files in `app/javascript`. The entry points are defined in `package.json`.

You can start a transpilation watch process with

```
yarn build --watch
```

This will watch for changes to `.js` files and transpile the applicaiton js automatically. Currently, there is no hot-reloading function.

## Foreman

A `.foreman` config file has been included for development convenience. To use foreman you will need to install the `foreman` gem on your system. Do not add it to the `Gemfile`.

```
gem install foreman
```

Once you've done that, you can run

```
foreman start
```

This will start three processes simultaneously:

- the SCSS compilation (`yarn build:css --watch`)
- the JS transpilation (`yarn build --watch`)
- the puma web server (`rails server`)

### Debugging with foreman

`pry-remote` has been added to the development group of the `Gemfile`. You can follow these steps to debugging when using foreman:

1. add `binding.pry_remote` where you want your breakpoint to be
2. `[pry-remote] Waiting for client on druby://127.0.0.1:9876` will appear in the foreman output
3. in a new terminal, enter `pry-remote`
4. you can then interact with the binding as normal
