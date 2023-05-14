#!/bin/bash

# Create a new directory for the project
mkdir $1
cd $1

# Initialize a new Node.js project
npm init -y

# Install necessary dependencies with specific ESLint and Jest versions
npm install --save-dev jest eslint babel-jest eslint-plugin-jest @babel/preset-env

# Initialize ESLint configuration
npx eslint --init --quiet

# Create Babel configuration
echo '{ "presets": ["@babel/preset-env"] }' > .babelrc

# Create source and test directories
mkdir src tests

# Create a sample source file
echo 'function sum(a, b) {
  return a + b;
}

module.exports = sum;' > src/example.js

# Create a sample test file
echo "import sum from '../src/example';

test('adds 1 + 2 to equal 3', () => {
  expect(sum(1, 2)).toBe(3);
});" > tests/example.test.js

# Update package.json scripts
jq '.scripts += { "test": "jest", "coverage": "jest --coverage" }' package.json > temp.json && mv temp.json package.json

# Update .eslintrc.json with basic lint rules
echo '{
  "extends": ["eslint:recommended"],
  "env": {
    "jest": true,
    "es6": true
  },
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module"
  },
  "rules": {}
}' > .eslintrc.json

echo "Project '$1' created successfully!"