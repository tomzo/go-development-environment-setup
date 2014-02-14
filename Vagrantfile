# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

class Environment
  EnvironmentSettingsFile = ".vagrant/go"

  def read variable, default = nil
    return ENV[variable] unless ENV[variable].nil?
    read_settings[variable] || default
  end

  def write variable, value
    settings = read_settings
    settings[variable] = value

    File.write EnvironmentSettingsFile, settings.to_json
  end

  private
  def read_settings
    return {} unless File.exists? EnvironmentSettingsFile

    JSON.parse File.read EnvironmentSettingsFile
  end
end

env = Environment.new

memory_to_use = env.read "MEMORY", "2048"
env.write "MEMORY", memory_to_use

puts "Will use #{memory_to_use}MB of RAM for the virtual machine."

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = true
  end

  config.vm.network :forwarded_port, guest: 8153, host: 8153, auto_correct: true
  config.vm.network :forwarded_port, guest: 8154, host: 8154, auto_correct: true

  # Choose an interface to bridge your network
  # config.vm.network :public_network

  config.vm.provider :virtualbox do |vb|
    vb.gui = env.read("HEADLESS") != "true"
    vb.memory = memory_to_use
  end

  config.vm.provision "shell", inline: "apt-get update"

  config.vm.provision :chef_solo do |chef|
    # chef.recipe_url = "https://raw.github.com/GoCD/go-dev-setup-cookbooks/master/cookbooks.tar.gz"
    chef.recipe_url = "https://dl.dropboxusercontent.com/s/1603y8w2rj761z5/cookbooks.tar.gz?dl=1&token_hash=AAECnZiz3SV7IPrXcZJ82hj6e74gVH2bO_T1957Qaj_Jhw"
    chef.cookbooks_path = [:vm, "go-dev-setup-cookbooks"]
    chef.verbose_logging = true

    chef.add_recipe "zip"

    chef.add_recipe "git"
    chef.add_recipe "subversion"

    chef.add_recipe "java"
    chef.add_recipe "maven"

    chef.add_recipe "ruby"
    chef.add_recipe "sass"
    chef.add_recipe "rake"

    chef.add_recipe "intellij" if env.read("TO_RUN_WITH_WINDOW_MANAGER") == "true"
    chef.add_recipe "gnome" if env.read("TO_RUN_WITH_WINDOW_MANAGER") == "true"
    chef.add_recipe "startup-setup" if env.read("TO_RUN_WITH_WINDOW_MANAGER") == "true"

    chef.add_recipe "startup-setup-console"
    chef.add_recipe "go-setup"

    chef.json = {
      'java' => {
        'install_flavor' => 'openjdk',
        'jdk_version' => '7'
      }
    }
  end

  $go_setup_script = <<SCRIPT
  if [ -d "cruise" ]; then
    echo "Go codebase seems to be checked out, already. Skipping it."
    exit 0
  fi

  set -e

  echo "Started checking out code from https://github.com/GoCD/gocd.tmp.git at: $(date)"
  git clone --progress https://testusergo:e86bff136c29f4ade63610bd8634118ae0951a0c@github.com/GoCD/gocd.tmp.git cruise 2>&1
  echo "Finished checking out code at: $(date)"
  cd cruise
  git submodule update --init --recursive
  ./b clean cruise:prepare
SCRIPT

  config.vm.provision "shell", privileged: false, inline: $go_setup_script
end
