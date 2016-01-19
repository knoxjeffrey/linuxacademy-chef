# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "knoxjeffrey"
client_key               "#{current_dir}/knoxjeffrey.pem"
validation_client_name   "jeff_linux_academy-validator"
validation_key           "#{current_dir}/jeff_linux_academy-validator.pem"
chef_server_url          "https://api.chef.io/organizations/jeff_linux_academy"
cookbook_path            ["#{current_dir}/../cookbooks"]
