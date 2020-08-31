---
layout: default
title: Users
nav_order: 1
parent: Client
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Users

## Get Users
```ruby
user = Opendistro.users
# => #<Opendistro::ObjectifiedHash:46080 {hash: {"logstash"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["logstash"], "attributes"=>{}, "description"=>"Demo logstash user", "opendistro_security_roles"=>[], "static"=>false}, "snapshotrestore"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["snapshotrestore"], "attributes"=>{}, "description"=>"Demo snapshotrestore user", "opendistro_security_roles"=>[], "static"=>false}, "admin"=>{"hash"=>"", "reserved"=>true, "hidden"=>false, "backend_roles"=>["admin"], "attributes"=>{}, "description"=>"Demo admin user", "opendistro_security_roles"=>[], "static"=>false}, "kibanaserver"=>{"hash"=>"", "reserved"=>true, "hidden"=>false, "backend_roles"=>[], "attributes"=>{}, "description"=>"Demo kibanaserver user", "opendistro_security_roles"=>[], "static"=>false}, "kibanaro"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["kibanauser", "readall"], "attributes"=>{"attribute1"=>"value1", "attribute2"=>"value2", "attribute3"=>"value3"}, "description"=>"Demo kibanaro user", "opendistro_security_roles"=>[], "static"=>false}, "readall"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["readall"], "attributes"=>{}, "description"=>"Demo readall user", "opendistro_security_roles"=>[], "static"=>false}}}
status.each_pair do |user, detail|
  puts "username: #{user}"
  puts "description: #{detail.description}"
end
# username: logstash
# description: Demo logstash user
# username: snapshotrestore
# description: Demo snapshotrestore user
# username: admin
# description: Demo admin user
# username: kibanaserver
# description: Demo kibanaserver user
# username: kibanaro
# description: Demo kibanaro user
# username: readall
# description: Demo readall user
```

## Get User
```ruby
user = Opendistro.user
# => #<Opendistro::ObjectifiedHash:46080 {hash: {"user_name"=>"admin", "is_reserved"=>true, "is_hidden"=>false, "is_internal_user"=>true, "user_requested_tenant"=>nil, "backend_roles"=>["admin"], "custom_attribute_names"=>[], "tenants"=>{"global_tenant"=>true, "admin_tenant"=>true, "admin"=>true}, "roles"=>["all_access", "own_index"]}}
user = Opendistro.user('kibanaro')
# => #<Opendistro::ObjectifiedHash:46080 {hash: {"kibanaro"=>{"hash"=>"", "reserved"=>false, "hidden"=>false, "backend_roles"=>["kibanauser", "readall"], "attributes"=>{"attribute1"=>"value1", "attribute2"=>"value2", "attribute3"=>"value3"}, "description"=>"Demo kibanaro user", "opendistro_security_roles"=>[], "static"=>false}}}
status = Opendistro.user('kibanaro')
status.to_hash.each_pair do |user, detail|
   puts "username: #{user}"
   puts "description: #{detail['description']}"
end
# username: kibanaro
# description: Demo kibanaro user
```

## Create User
```ruby
user = Opendistro.create_user('test_user','secret', { description: 'user for test' })
# => <Opendistro::ObjectifiedHash:46080 {hash: {"status"=>"CREATED", "message"=>"'test_user' created."}}
user.status == 'CREATED'
# => true
```

## Edit User
```ruby
modify = [{ 'op' => 'replace', 'path': '/description', 'value': 'new description' }]
user = Opendistro.edit_user('test_user', modify)
# => #<Opendistro::ObjectifiedHash:46080 {hash: {"status"=>"OK", "message"=>"'test_user' updated."}}
user.status == 'OK'
# => true
```

## Delete User
```ruby
users = Opendistro.delete_user('test_users')
# => #<Opendistro::ObjectifiedHash:46080 {hash: {"status"=>"OK", "message"=>"'test_user' deleted."}}
user.status == 'OK'
# => true
```

# Cache

## Flush Cache
```ruby
cache = Opendistro.flush_cache()
# => #<Opendistro::ObjectifiedHash:46220 {hash: {"status"=>"OK", "message"=>"Cache flushed successfully."}}
cache.status == 'OK'
# => true
```
