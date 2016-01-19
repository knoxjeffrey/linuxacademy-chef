default["apache"]["sites"]["knoxjeffrey2"] = { "site_title" => "Knoxjeffrey2s website coming soon",
																							 "port" => 80,
																							 "domain" => "knoxjeffrey2.mylabserver.com" }

default["apache"]["sites"]["knoxjeffrey2b"] = { "site_title" => "Knoxjeffrey2bs website coming soon!",
																								"port" => 80,
																								"domain" => "knoxjeffrey2b.mylabserver.com" }
default["apache"]["sites"]["knoxjeffrey3"] = { "site_title" => "Knoxjeffrey3 website",
                                                "port" => 80,
                                                "domain" => "knoxjeffrey3.mylabserver.com" } 

case node["platform"]
when "centos"
	default["apache"]["package"] = "httpd"
when "ubuntu"
	default["apache"]["package"] = "apache2"
end

