#
# Cookbook Name:: fulcrum
# Recipe:: default
#
# Copyright 2013, misty-magic.h
#

##################################################
# プラットフォームチェック
##################################################
if node['kernel']['machine'] != "x86_64" or node['platform'] != "centos" or node['platform_version'].to_f != 6.4
	log "This recipe is Centos 6.4 x86_64 Only." do
	  level :error
	end
end

##################################################
# ファイアーウォールの無効か
##################################################
service "iptables" do
    action [ :disable, :stop ]
end


##################################################
# YUMのremiリポジトリを追加
##################################################
#include_recipe "yum::remi"
include_recipe "yum::default"
execute "sudo yum update -y"
execute "sudo rpm --import https://fedoraproject.org/static/0608B895.txt"
execute "sudo rpm -Uvh http://download-i2.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm"

##################################################
# 依存パッケージのインストール
##################################################
#yum_repository "epel-qt48" do
#	description "Software Collection for Qt 4.8"
#	url "http://repos.fedorapeople.org/repos/sic/qt48/epel-$releasever/$basearch/"
#	enabled 1
#end

#package "qt48-qt-webkit-devel"

#bash "setup qt48" do
#	user "root"
#	group "root"
#	code <<-EOC
#		ln -s /opt/rh/qt48/root/usr/include/QtCore/qconfig-64.h  /opt/rh/qt48/root/usr/include/QtCore/qconfig-x86_64.h
#	EOC
#	creates "/opt/rh/qt48/root/usr/include/QtCore/qconfig-x86_64.h"
#end

#ENV['PATH'] = "/opt/rh/qt48/root/usr/bin:/opt/rh/qt48/root/usr/lib64/qt4/bin/:#{ENV['PATH']}"

package "nodejs" do
	options("--enablerepo=epel")
end

%w{git libxml2-devel libxslt-devel postgresql-devel}.each do |pkg|
	package pkg
end

execute "sudo /usr/local/rvm/bin/rvm install 2.0.0"
execute "sudo /usr/local/rvm/bin/rvm use 2.0.0 --default"


##################################################
# ruby gemの依存パッケージ追加
##################################################
gem_package "bundler"
gem_package "execjs"


##################################################
# fulcrumをgithubからクローン
##################################################
git "/home/vagrant/fulcrum" do
	repository "git://github.com/malclocke/fulcrum.git"
	reference "master"
	action :checkout
	user "vagrant"
	group "vagrant"
end

##################################################
# fulcrumで利用する依存ruby gemパッケージ追加
##################################################
bash "install depends on fulcrum" do
	user "vagrant"
	group "vagrant"
	cwd "/home/vagrant/fulcrum"
	
	code <<-EOC
		bundle install --path=vendor/bundle
	EOC
end

##################################################
# fulcrum 初期設定＆DB初期化
##################################################
bash "setup fulcrum" do
	user "vagrant"
	group "vagrant"
	cwd "/home/vagrant/fulcrum"
	
	code <<-EOC
		bundle exec rake fulcrum:setup db:setup
	EOC
    
    creates "/home/vagrant/fulcrum/config/database.yml"
end

##################################################
# rails開始
##################################################
bash "start rails" do
	user "vagrant"
	group "vagrant"
	cwd "/home/vagrant/fulcrum"
	
	code <<-EOC
        ./script/rails server -d
	EOC
end

