#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
if node["platform"] == "ubuntu"
	execute "apt-get update -y" do
	end
end

package "apache2" do
	package_name node["apache"]["package"]
end

# For each site in the apache attributes file do the following. 
# eg in this file you have default["apache"]["sites"]["knoxjeffrey"]
#		in this case the site name is knoxjeffrey
#		date will be { "port" => 80, ... }
node["apache"]["sites"].each do |sitename, data|
	document_root = "/content/sites/#{sitename}"
	
	directory document_root do
		mode "0755" # For the owner set read/write/execute, everyone else read/execute
		recursive true # For anything that does not exist, create it.
	end
	
	# Populate the named source file in the templates directory  and place it in the 
	# template file
	if node["platform"] == "ubuntu"
		template_location = "/etc/apache2/sites-enabled/#{sitename}.conf"
	elsif node["platform"] == "centos"
		template_location = "/etc/httpd/conf.d/#{sitename}.conf"
	end

	template template_location do
		source "vhost.erb"
		mode "0644" # Read and write for owner and read/read for everyone else
		variables(
			:document_root	=> document_root,
			:port						=> data["port"],
			:domain					=> data["domain"]
		)
		notifies :restart, "service[httpd]" # For this to apply we need to restart apache
	end
	
	template "/content/sites/#{sitename}/index.html" do
		source "index.html.erb"
		mode "0644"
		variables(
			:site_title => data["site_title"],
			:coming_soon => "Coming Soon!"
		)
	end
end

# Execute the remove command only if the named file exists
execute "rm /etc/httpd/conf.d/welcome.conf" do
	only_if do
		File.exist?("/etc/httpd/conf.d/welcome.conf")
	end
	notifies :restart, "service[httpd]"
end

execute "rm /etc/httpd/conf.d/README" do
  only_if do
    File.exist?("/etc/httpd/conf.d/README")
  end
  notifies :restart, "service[httpd]"
end

service "httpd" do
	service_name node["apache"]["package"]
	action [:enable, :start]
end

#include_recipe "php::default"
