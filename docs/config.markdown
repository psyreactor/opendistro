---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
title: Configuration
nav_order: 2
---

# Configuration

## Create a connection

Before you can make a request, you must give Opendistro your connection information.

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


## SSL config disabled
```ruby
Opendistro.configure do |config|
  config.endpoint       = 'https://example.net:9200' 
  config.username       = 'useradmin'
  config.password       = 'secretpassword'
  config.verify_ssl   = false
end
```

All of these parameters are also configurable via the top-level Opendistro object.

## Top-level Opendistro Object
```ruby
# set an API endpoint
Opendistro.endpoint = 'https://example.net:9200'
# => "https://example.net:9200"

# set a username
Opendistro.username = 'admin'
# => "admin"
# set a user password
Opendistro.password = 'secretpassword'
# => "admin"
# disable ssl verify
Opendistro.httparty = { verify: false }

# configure a proxy server
Opendistro.http_proxy('proxyhost', 8888)
# proxy server with basic auth
Opendistro.http_proxy('proxyhost', 8888, 'proxyuser', 'strongpasswordhere')
```

Or, if you want to be really Unixy, these parameters are all configurable via environment variables:

## Opendistro will use these env

```
ENV['OPENDISTRO_API_ENDPOINT']         = 'https://example.com:9000'
ENV['OPENDISTRO_API_USER']             = 'admin'
ENV['OPENDISTRO_API_PASSWORD']         = 'secretpassword'
ENV['OPENDISTRO_API_CA_CERT_PATH']     = '/etc/pki/ca_cert'
ENV['OPENDISTRO_API_HTTPARTY_OPTIONS'] = '{ headers: { 'Cookie' => 'opendistro_canary=true' }}'
ENV['OPENDISTRO_API_VERIFY_SSL']       = false
```
You can also create a full Client object with hash parameters:


## object with hash parameters

```ruby
sonar = Opendistro.client(
  endpoint: 'https://example.com:9200',
  username: 'admin',
  password: 'secretpassword'
  httparty: {
    headers: { 'Cookie' => 'opendistro_canary=true' }
  }
)
# => #<Opendistro::Client:0x00000001e62408 @endpoint="https://api.example.com:9200", @username="admin", @password="secretpassword",@user_agent="Opendistro Ruby Gem 2.0.0">
```