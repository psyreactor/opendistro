---
layout: default
title: Roles
nav_order: 2
parent: Client
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
2. TOC
{:toc}
</details>

# Roles

## Get Roles
```ruby
role = Opendistro.roles
# => <Opendistro::ObjectifiedHash:46200 {hash: {"readall_and_monitor"=>{"reserved"=>true, "hidden"=>false, "description"=>"Provide the minimum permissions for to readall indices and monitor the cluster", "cluster_permissions"=>["cluster_monitor", "cluster_composite_ops_ro"], "index_permissions"=>[{"index_patterns"=>["*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["read"]}], "tenant_permissions"=>[], "static"=>true}, "alerting_view_alerts"=>{"reserved"=>true, "hidden"=>false, "cluster_permissions"=>[], "index_permissions"=>[{"index_patterns"=>[".opendistro-alerting-alert*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["read"]}], "tenant_permissions"=>[], "static"=>false}, "kibana_user"=>{"reserved"=>true, "hidden"=>false, "description"=>"Provide the minimum permissions for a kibana user", "cluster_permissions"=>["cluster_composite_ops"], "index_permissions"=>[{"index_patterns"=>[".kibana", ".kibana-6", ".kibana_*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["read", "delete", "manage", "index"]}, {"index_patterns"=>[".tasks", ".management-beats", "*:.tasks", "*:.management-beats"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}], "tenant_permissions"=>[], "static"=>true}, "own_index"=>{"reserved"=>true, "hidden"=>false, "description"=>"Allow all for indices named like the current user", "cluster_permissions"=>["cluster_composite_ops"], "index_permissions"=>[{"index_patterns"=>["${user_name}"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}], "tenant_permissions"=>[], "static"=>true}, "kibana_read_only"=>{"reserved"=>true, "hidden"=>false, "cluster_permissions"=>[], "index_permissions"=>[], "tenant_permissions"=>[], "static"=>false}, "alerting_full_access"=>{"reserved"=>true, "hidden"=>false, "cluster_permissions"=>[], "index_permissions"=>[{"index_patterns"=>[".opendistro-alerting-config", ".opendistro-alerting-alert*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["crud"]}], "tenant_permissions"=>[], "static"=>false}, "all_access"=>{"reserved"=>true, "hidden"=>false, "description"=>"Allow full access to all indices and all cluster APIs", "cluster_permissions"=>["*"], "index_permissions"=>[{"index_patterns"=>["*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["*"]}], "tenant_permissions"=>[{"tenant_patterns"=>["*"], "allowed_actions"=>["kibana_all_write"]}], "static"=>true}, "readall"=>{"reserved"=>true, "hidden"=>false, "description"=>"Provide the minimum permissions for to readall indices", "cluster_permissions"=>["cluster_composite_ops_ro"], "index_permissions"=>[{"index_patterns"=>["*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["read"]}], "tenant_permissions"=>[], "static"=>true}, "manage_snapshots"=>{"reserved"=>true, "hidden"=>false, "description"=>"Provide the minimum permissions for managing snapshots", "cluster_permissions"=>["manage_snapshots"], "index_permissions"=>[{"index_patterns"=>["*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices:data/write/index", "indices:admin/create"]}], "tenant_permissions"=>[], "static"=>true}, "logstash"=>{"reserved"=>true, "hidden"=>false, "description"=>"Provide the minimum permissions for logstash and beats", "cluster_permissions"=>["cluster_monitor", "cluster_composite_ops", "indices:admin/template/get", "indices:admin/template/put", "cluster:admin/ingest/pipeline/put", "cluster:admin/ingest/pipeline/get"], "index_permissions"=>[{"index_patterns"=>["logstash-*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["crud", "create_index"]}, {"index_patterns"=>["*beat*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["crud", "create_index"]}], "tenant_permissions"=>[], "static"=>true}, "my_test_role"=>{"reserved"=>false, "hidden"=>false, "cluster_permissions"=>["cluster_composite_ops", "indices_monitor"], "index_permissions"=>[{"index_patterns"=>["api-prueba*"], "dls"=>"", "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["read"]}], "tenant_permissions"=>[{"tenant_patterns"=>["human_resources"], "allowed_actions"=>["kibana_all_read"]}], "static"=>false}, "my_test_role3"=>{"reserved"=>false, "hidden"=>false, "cluster_permissions"=>["cluster_composite_ops", "indices_monitor"], "index_permissions"=>[{"index_patterns"=>["api*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["read"]}], "tenant_permissions"=>[{"tenant_patterns"=>["human_resources"], "allowed_actions"=>["kibana_all_read"]}], "static"=>false}, "security_rest_api_access"=>{"reserved"=>true, "hidden"=>false, "cluster_permissions"=>[], "index_permissions"=>[], "tenant_permissions"=>[], "static"=>false}, "alerting_crud_alerts"=>{"reserved"=>true, "hidden"=>false, "cluster_permissions"=>[], "index_permissions"=>[{"index_patterns"=>[".opendistro-alerting-alert*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["crud"]}], "tenant_permissions"=>[], "static"=>false}, "kibana_server"=>{"reserved"=>true, "hidden"=>false, "description"=>"Provide the minimum permissions for the Kibana server", "cluster_permissions"=>["cluster_monitor", "cluster_composite_ops", "cluster:admin/xpack/monitoring*", "indices:admin/template*", "indices:data/read/scroll*"], "index_permissions"=>[{"index_patterns"=>[".kibana"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>[".kibana-6"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>[".kibana_*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>[".reporting*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>[".monitoring*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>[".tasks"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>[".management-beats*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>["*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices:admin/aliases*"]}], "tenant_permissions"=>[], "static"=>true}}}
role.each_pair do |role, detail|
  puts "role: #{role}"
  puts "reserved: #{detail.reserved}"
end
# role: readall_and_monitor
# reserved: true
# role: alerting_view_alerts
# reserved: true
# role: kibana_user
# reserved: true
# role: own_index
# reserved: true
# role: kibana_read_only
# reserved: true
# role: alerting_full_access
# reserved: true
# role: all_access
# reserved: true
# role: readall
# reserved: true
# role: manage_snapshots
# reserved: true
# role: logstash
# reserved: true
# role: my_test_role
# reserved: false
# role: my_test_role3
# reserved: false
# role: security_rest_api_access
# reserved: true
# role: alerting_crud_alerts
# reserved: true
# role: kibana_server
# reserved: true
```

## Get Role
```ruby
role = Opendistro.role
# => <Opendistro::ObjectifiedHash:46200 {hash: {"readall_and_monitor"=>{"reserved"=>true, "hidden"=>false, "description"=>"Provide the minimum permissions for to readall indices and monitor the cluster", "cluster_permissions"=>["cluster_monitor", "cluster_composite_ops_ro"], "index_permissions"=>[{"index_patterns"=>["*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["read"]}], "tenant_permissions"=>[], "static"=>true}, "alerting_view_alerts"=>{"reserved"=>true, "hidden"=>false, "cluster_permissions"=>[], "index_permissions"=>[{"index_patterns"=>[".opendistro-alerting-alert*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["read"]}], "tenant_permissions"=>[], "static"=>false}, "kibana_user"=>{"reserved"=>true, "hidden"=>false, "description"=>"Provide the minimum permissions for a kibana user", "cluster_permissions"=>["cluster_composite_ops"], "index_permissions"=>[{"index_patterns"=>[".kibana", ".kibana-6", ".kibana_*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["read", "delete", "manage", "index"]}, {"index_patterns"=>[".tasks", ".management-beats", "*:.tasks", "*:.management-beats"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}], "tenant_permissions"=>[], "static"=>true}, "own_index"=>{"reserved"=>true, "hidden"=>false, "description"=>"Allow all for indices named like the current user", "cluster_permissions"=>["cluster_composite_ops"], "index_permissions"=>[{"index_patterns"=>["${user_name}"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}], "tenant_permissions"=>[], "static"=>true}, "kibana_read_only"=>{"reserved"=>true, "hidden"=>false, "cluster_permissions"=>[], "index_permissions"=>[], "tenant_permissions"=>[], "static"=>false}, "alerting_full_access"=>{"reserved"=>true, "hidden"=>false, "cluster_permissions"=>[], "index_permissions"=>[{"index_patterns"=>[".opendistro-alerting-config", ".opendistro-alerting-alert*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["crud"]}], "tenant_permissions"=>[], "static"=>false}, "all_access"=>{"reserved"=>true, "hidden"=>false, "description"=>"Allow full access to all indices and all cluster APIs", "cluster_permissions"=>["*"], "index_permissions"=>[{"index_patterns"=>["*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["*"]}], "tenant_permissions"=>[{"tenant_patterns"=>["*"], "allowed_actions"=>["kibana_all_write"]}], "static"=>true}, "readall"=>{"reserved"=>true, "hidden"=>false, "description"=>"Provide the minimum permissions for to readall indices", "cluster_permissions"=>["cluster_composite_ops_ro"], "index_permissions"=>[{"index_patterns"=>["*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["read"]}], "tenant_permissions"=>[], "static"=>true}, "manage_snapshots"=>{"reserved"=>true, "hidden"=>false, "description"=>"Provide the minimum permissions for managing snapshots", "cluster_permissions"=>["manage_snapshots"], "index_permissions"=>[{"index_patterns"=>["*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices:data/write/index", "indices:admin/create"]}], "tenant_permissions"=>[], "static"=>true}, "logstash"=>{"reserved"=>true, "hidden"=>false, "description"=>"Provide the minimum permissions for logstash and beats", "cluster_permissions"=>["cluster_monitor", "cluster_composite_ops", "indices:admin/template/get", "indices:admin/template/put", "cluster:admin/ingest/pipeline/put", "cluster:admin/ingest/pipeline/get"], "index_permissions"=>[{"index_patterns"=>["logstash-*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["crud", "create_index"]}, {"index_patterns"=>["*beat*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["crud", "create_index"]}], "tenant_permissions"=>[], "static"=>true}, "security_rest_api_access"=>{"reserved"=>true, "hidden"=>false, "cluster_permissions"=>[], "index_permissions"=>[], "tenant_permissions"=>[], "static"=>false}, "alerting_crud_alerts"=>{"reserved"=>true, "hidden"=>false, "cluster_permissions"=>[], "index_permissions"=>[{"index_patterns"=>[".opendistro-alerting-alert*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["crud"]}], "tenant_permissions"=>[], "static"=>false}, "kibana_server"=>{"reserved"=>true, "hidden"=>false, "description"=>"Provide the minimum permissions for the Kibana server", "cluster_permissions"=>["cluster_monitor", "cluster_composite_ops", "cluster:admin/xpack/monitoring*", "indices:admin/template*", "indices:data/read/scroll*"], "index_permissions"=>[{"index_patterns"=>[".kibana"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>[".kibana-6"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>[".kibana_*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>[".reporting*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>[".monitoring*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>[".tasks"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>[".management-beats*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices_all"]}, {"index_patterns"=>["*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["indices:admin/aliases*"]}], "tenant_permissions"=>[], "static"=>true}}}
role = Opendistro.role('readall_and_monitor')
# => <Opendistro::ObjectifiedHash:46220 {hash: {"readall_and_monitor"=>{"reserved"=>true, "hidden"=>false, "description"=>"Provide the minimum permissions for to readall indices and monitor the cluster", "cluster_permissions"=>["cluster_monitor", "cluster_composite_ops_ro"], "index_permissions"=>[{"index_patterns"=>["*"], "fls"=>[], "masked_fields"=>[], "allowed_actions"=>["read"]}], "tenant_permissions"=>[], "static"=>true}}}
status = Opendistro.role('readall_and_monitor')
status.to_hash.each_pair do |role, detail|
   puts "role: #{role}"
   puts "description: #{detail['description']}"
end
# role: readall_and_monitor
# description: Provide the minimum permissions for to readall indices and monitor the cluster
```

## Create Role
```ruby
role = Opendistro.create_role('my_test_role', { cluster_permissions: %w[cluster_composite_ops indices_monitor], description: 'role for test.', index_permissions: [{ index_patterns: ['api-*'], dls: '', fls: [], masked_fields: [], allowed_actions: ['read'] }], tenant_permissions: [{ allowed_actions: ['kibana_all_read'] }] })
# => <Opendistro::ObjectifiedHash:46260 {hash: {"status"=>"CREATED", "message"=>"'my_test_role' created."}}
role.status == 'CREATED'
# => true
```

## Edit Role
```ruby
modify = { description: 'role for test - Updated.', index_permissions: [{ index_patterns: ['api*'], dls: '', fls: [], masked_fields: [], allowed_actions: ['read'] }] }
role = Opendistro.edit_role('my_test_role', modify)
# => <Opendistro::ObjectifiedHash:46280 {hash: {"status"=>"OK", "message"=>"'my_test_role' updated."}}
role.status == 'OK'
# => true
```

## Edit Role Attribute
```ruby
modify = [{ 'op' => 'replace', 'path': '/description', 'value': 'new description' }]
role = Opendistro.edit_role_attribute('my_test_role_01', modify)
# => <Opendistro::ObjectifiedHash:46200 {hash: {"status"=>"OK", "message"=>"'my_test_role_01' updated."}}
role.status == 'OK'
# => true
```

## Delete Role
```ruby
role = Opendistro.delete_role('my_test_role_01')
# => <Opendistro::ObjectifiedHash:46220 {hash: {"status"=>"OK", "message"=>"'my_test_role_01' deleted."}}
role.status == 'OK'
# => true
```
