
# vagrant user and its home is expected by many setup scripts
user 'vagrant' do
  shell '/bin/bash'
  home  '/home/vagrant'
  system false
  manage_home true
  action :create
end

include_recipe "zip"

include_recipe "git"
include_recipe "subversion"

include_recipe "java"
include_recipe "maven"

include_recipe "ruby"
include_recipe "sass"
include_recipe "rake"
include_recipe "curl"

if node['go-dev-env']['gui']
  include_recipe "intellij"
  include_recipe "gnome"
  include_recipe "startup-setup"
end

include_recipe "startup-setup-console"
include_recipe "remove-unused-packages"
include_recipe "go-setup"
