#
# Cookbook Name:: lamp
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rightscale_marker :begin

# Set the LAMP specific node variables.
#
# Make sure to run this recipe after the php application server default recipe
# to ensure that it does not over write these values.

# Don't reset the binding or this breaks the MySQL replication config
node[:db_mysql][:bind_address] = node[:cloud][:private_ips][0]
log "  LAMP set MySQL to listen on #{node[:cloud][:private_ips][0]}"

node[:app][:port] = "80"
log "  LAMP set Apache to listen on port #{node[:app][:port]}"

# Setup default values for application resource and install required packages.
app "default" do
  persist true
  provider node[:app][:provider]
  packages node[:app][:packages]
  action :install
end

rightscale_marker :end
