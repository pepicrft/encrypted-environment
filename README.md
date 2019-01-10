# Encrypted enironment

[![CircleCI](https://circleci.com/gh/pepibumur/encrypted-environment.svg?style=svg)](https://circleci.com/gh/pepibumur/encrypted-environment)
[![codecov](https://codecov.io/gh/pepibumur/encrypted-environment/branch/master/graph/badge.svg)](https://codecov.io/gh/pepibumur/encrypted-environment)
[![Gem Version](https://badge.fury.io/rb/encrypted-environment.svg)](https://badge.fury.io/rb/encrypted-environment)

Ruby utility to load encrypted variables into the environment

## Install

1. Add the following line to the Gemfile:

```
gem "encrypted-environment", git: "git@github.com:pepibumur/encrypted-environment.git"
```

2. Run `bundle install`

## Usage

```ruby
require "encrypted/environment"

Encrypted::Environment.load_from_ejson(
  "path/to/env.ejson",
  secrets_path: "secrets",
  private_key: "key"
)

Encrypted::Environment.encrypt_ejson(
  "path/to/env.ejson",
  secrets_path: "secrets",
  private_key: "key"
)
```
