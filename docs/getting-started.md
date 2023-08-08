# Getting started

## Pre-requisites

### Node

Node v20+ is required. There is an `.nvmrc` file that contains the version currently used by this project. It is recommended to install and use [node version manager](https://github.com/nvm-sh/nvm) to manage the node versions you have installed on your machine, especially if you are working across products.

### Yarn

Yarn v1+ is required. This project does not use `npm` to manage js dependencies.

### Ruby

Ruby v3.2+ is required. There is a `.ruby-version` file that contains the version currently used by this project. It is recommended to install and use [ruby version manager](https://rvm.io/) to manage the ruby versions you have installed on your machine, especially if you are working across products.

## Setup

All example commands should be run from the root of the project directory.

1. Install the pre-requisites above
2. Make sure you're running the correct ruby version

   ```
   rvm use
   ```

3. Make sure you're running the correct node version

   ```
   nvm use
   ```

4. Run the rails setup script
   ```
   bin/setup
   ```
