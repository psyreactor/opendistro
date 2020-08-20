# Opendistro

[![Build Status](https://img.shields.io/github/workflow/status/NARKOZ/opendistro/CI/master)](https://github.com/NARKOZ/opendistro/actions?query=workflow%3ARuby)
[![Inline docs](https://inch-ci.org/github/NARKOZ/opendistro.svg)](https://inch-ci.org/github/NARKOZ/opendistro)
[![Gem version](https://img.shields.io/gem/v/opendistro.svg)](https://rubygems.org/gems/opendistro)
[![License](https://img.shields.io/badge/license-BSD-red.svg)](https://github.com/NARKOZ/opendistro/blob/master/LICENSE.txt)

[website](https://narkoz.github.io/opendistro) |
[documentation](https://www.rubydoc.info/gems/opendistro/frames) |
[opendistro-live](https://github.com/NARKOZ/opendistro-live)

A Ruby wrapper around the Opendistro API.

This library will strive to achieve reliable coverage of the Opendistro API. Please submit an issue if you find a bug and feel free to submit a pull request to contribute fixes or new features.

Initial versions of this gem to not achieve 100% coverage of the Opendistro API. Each release will include more and more endpoint support until there is 100% coverage.

The layout and the code in this library is inspired by https://github.com/NARKOZ/opendistro. NARKOZ does a fantastic job of keeping code simple and achieving API feature parity.

## Installation

Install it from rubygems:

```sh
gem install opendistro
```

Or add to a Gemfile:

```ruby
gem 'opendistro'
# gem 'opendistro', github: 'psyreactor/opendistro'
```

Mac OS users can install using Homebrew (may not be the latest version):

```sh
brew install opendistro-gem
```

## Usage

Configuration example:

```ruby
Opendistro.configure do |config|
  config.endpoint       = 'https://example.net:9200' 
  config.username       = 'useradmin'
  config.password       = 'secretpassword'
  # Optional
  # config.user_agent   = 'Custom User Agent'
  # config.verify_ssl   = false
  # config.ca_cert      = '/etc/pki/ca_cert/ca.crt'
end
```

Usage examples:

```ruby
# set an API endpoint
Opendistro.endpoint = 'https://example.net:9200'
# => "https://example.net:9200"

# set a user user
Opendistro.username = 'useradmin'
# => "useradmin"

# set a user password
Opendistro.password  = 'secretpassword'
# => "secretpassword"

# configure a proxy server
Opendistro.http_proxy('proxyhost', 8888)
# proxy server with basic auth
Opendistro.http_proxy('proxyhost', 8888, 'proxyuser', 'strongpasswordhere')
# set timeout for responses
ENV['OPENDISTRO_API_HTTPARTY_OPTIONS'] = '{read_timeout: 60}'

# list users
Opendistro.users()
# #<Opendistro::ObjectifiedHash:46080 {hash: {"logstash"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["logstash"], "attributes"=>{}, "description"=>"Demo logstash user", "opendistro_security_roles"=>[], "static"=>false}, "snapshotrestore"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["snapshotrestore"], "attributes"=>{}, "description"=>"Demo snapshotrestore user", "opendistro_security_roles"=>[], "static"=>false}, "admin"=>{"hash"=>"", "reserved"=>true, "hidden"=>false, "backend_roles"=>["admin"], "attributes"=>{}, "description"=>"Demo admin user", "opendistro_security_roles"=>[], "static"=>false}, "kibanaserver"=>{"hash"=>"", "reserved"=>true, "hidden"=>false, "backend_roles"=>[], "attributes"=>{}, "description"=>"Demo kibanaserver user", "opendistro_security_roles"=>[], "static"=>false}, "kibanaro"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["kibanauser", "readall"], "attributes"=>{"attribute1"=>"value1", "attribute2"=>"value2", "attribute3"=>"value3"}, "description"=>"Demo kibanaro user", "opendistro_security_roles"=>[], "static"=>false}, "readall"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["readall"], "attributes"=>{}, "description"=>"Demo readall user", "opendistro_security_roles"=>[], "static"=>false}}}

# initialize a new client with custom headers
od = Opendistro.client(
  endpoint: 'https://example.com:9200',
  username: 'useradmin',
  password: 'secretpassword',
  httparty: {
    headers: { 'Cookie' => 'opendistro_canary=true' }
  }
)

# get a users
user = od.users
#<Opendistro::ObjectifiedHash:46080 {hash: {"logstash"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["logstash"], "attributes"=>{}, "description"=>"Demo logstash user", "opendistro_security_roles"=>[], "static"=>false}, "snapshotrestore"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["snapshotrestore"], "attributes"=>{}, "description"=>"Demo snapshotrestore user", "opendistro_security_roles"=>[], "static"=>false}, "admin"=>{"hash"=>"", "reserved"=>true, "hidden"=>false, "backend_roles"=>["admin"], "attributes"=>{}, "description"=>"Demo admin user", "opendistro_security_roles"=>[], "static"=>false}, "kibanaserver"=>{"hash"=>"", "reserved"=>true, "hidden"=>false, "backend_roles"=>[], "attributes"=>{}, "description"=>"Demo kibanaserver user", "opendistro_security_roles"=>[], "static"=>false}, "kibanaro"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["kibanauser", "readall"], "attributes"=>{"attribute1"=>"value1", "attribute2"=>"value2", "attribute3"=>"value3"}, "description"=>"Demo kibanaro user", "opendistro_security_roles"=>[], "static"=>false}, "readall"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["readall"], "attributes"=>{}, "description"=>"Demo readall user", "opendistro_security_roles"=>[], "static"=>false}}}

# get a user's 
user = od.user('logstash')

# get user description
user.description
# => 'logstash demo user'

```


## Development

### With a dockerized Opendistro instance

```shell
docker-compose up -d opendistro # Will start the Opendistro instance in the background (approx. 3 minutes)
```

After a while, your Opendistro instance will be accessible on http://localhost:9200.

Once you have set your new password admin, you can login with the admin user.

Once you have your token, set the variables to the correct values in the `docker.env` file.

Then, launch the tool:

```shell
docker-compose run app
```

```ruby
Opendistro.users
=> #<Opendistro::ObjectifiedHash:46080 {hash: {"logstash"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["logstash"], "attributes"=>{}, "description"=>"Demo logstash user", "opendistro_security_roles"=>[], "static"=>false}, "snapshotrestore"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["snapshotrestore"], "attributes"=>{}, "description"=>"Demo snapshotrestore user", "opendistro_security_roles"=>[], "static"=>false}, "admin"=>{"hash"=>"", "reserved"=>true, "hidden"=>false, "backend_roles"=>["admin"], "attributes"=>{}, "description"=>"Demo admin user", "opendistro_security_roles"=>[], "static"=>false}, "kibanaserver"=>{"hash"=>"", "reserved"=>true, "hidden"=>false, "backend_roles"=>[], "attributes"=>{}, "description"=>"Demo kibanaserver user", "opendistro_security_roles"=>[], "static"=>false}, "kibanaro"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["kibanauser", "readall"], "attributes"=>{"attribute1"=>"value1", "attribute2"=>"value2", "attribute3"=>"value3"}, "description"=>"Demo kibanaro user", "opendistro_security_roles"=>[], "static"=>false}, "readall"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["readall"], "attributes"=>{}, "description"=>"Demo readall user", "opendistro_security_roles"=>[], "static"=>false}}}

```
To launch the specs:

```shell
docker-compose run app rake spec
```

### With an external Opendistro instance

First, set the variables to the correct values in the `docker.env` file.

Then, launch the tool:

```shell
docker-compose run app
```

```ruby
Opendistro.users
```

To launch the specs,

```shell
docker-compose run app rake spec
```

## License

Released under the BSD 2-clause license. See LICENSE.txt for details.
