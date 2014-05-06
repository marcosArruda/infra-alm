name             'chef-fulcrum'
maintainer       'misty-magic.h'
maintainer_email 'mistymagich@users.noreply.github.com'
license          'MIT License'
description      'Installs/Configures Fulcrum on CentOS 6.4 x86_64'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ centos }.each do |os|
      supports os, "= 6.4"
end

depends 'yum'

