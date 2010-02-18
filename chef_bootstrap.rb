#!/usr/bin/env ruby

# Run this script to initially setup a bare server.
#
# Instructions:
# SSH this file to a bare server that we intend to deploy to with chef.  This gives us the bare minimum of
# config tools including ruby, rubygems, chef.  Run it from the /tmp dir on the remote machine since we don't
# care if it is lost once we have run it once.  This script assumes that Ruby is already installed.

#scp ~/.ssh/id_rsa.pub root@yourserver:.ssh/authorized_keys2
#scp chef_bootstrap.rb root@yourserver:/tmp/
#ssh root@yourserver
#- aptitude -y install ruby;ruby /tmp/chef_bootstrap.rb

# WARNING : This has only been tested on Ubuntu.  This only needs to be run to bootstrap a bare AMI.

def cmd(cmd)
  puts cmd; system(cmd)
end

puts "------------------------"
puts "Installing Chef"
puts

cmd "aptitude -y update"
cmd "aptitude -y install irb ri rdoc libshadow-ruby1.8 ruby1.8-dev gcc g++ curl rsync libopenssl-ruby1.8"

cmd "curl -L 'http://rubyforge.org/frs/download.php/57643/rubygems-1.3.4.tgz' | tar xvzf -"
cmd "cd rubygems* && ruby setup.rb --no-ri --no-rdoc"

cmd "ln -sfv /usr/bin/gem1.8 /usr/bin/gem"

cmd "gem install rdoc chef ohai --no-ri --no-rdoc --source http://gems.opscode.com --source http://gems.rubyforge.org"

puts
puts "It seems to have worked!"
puts "------------------------"

