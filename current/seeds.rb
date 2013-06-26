#!/usr/local/bin/ruby
#
# This file should contain all the record creation need to seed the
# database with its default values. The data can then be loaded with the command rake db:seed

require 'rubygems'
require 'sequel'
require 'sqlite3'



#DB = SQLite3::Database.open "./cmw.db"
DB = Sequel.connect('sqlite://cmw.db')


begin
  menus = DB[:menus]
  menus.insert(:text => 'Our Club', :target => '/ourclub', :parent => '0', :secure => '0', :weight => '1', :group => '0')
  menus.insert(:text => 'Training', :target => '/training', :parent => '0', :secure => '0', :weight => '5', :group => '0')
  menus.insert(:text => 'Login', :target => '/login', :parent => '0', :secure => '-1', :weight => '10', :group => '0')
  menus.insert(:text => 'Logout', :target => '/logout', :parent => '0', :secure => '0', :weight => '15', :group => '0')
  menus.insert(:text => 'Register', :target => '/register', :parent => '0', :secure => '-1', :weight => '15', :group => '0')
  menus.insert(:text => 'My Profile', :target => '/myprofile', :parent => '0', :secure => '1', :weight => '15', :group => '0')
  menus.insert(:text => 'Actions', :target => '/actions', :parent => '0', :secure => '1', :weight => '20', :group => '0')

  menus.insert(:text => 'History', :target => '/history', :parent => '1', :secure => '0', :weight => '1', :group => '0')
  menus.insert(:text => 'Coaches', :target => '/coaches', :parent => '1', :secure => '0', :weight => '5', :group => '0')

  menus.insert(:text => 'Timetable', :target => '/timetable', :parent => '2', :secure => '0', :weight => '1', :group => '0')
  menus.insert(:text => 'Fees', :target => '/fees', :parent => '2', :secure => '0', :weight => '5', :group => '0')
  menus.insert(:text => 'Courses', :target => '/courses', :parent => '2', :secure => '0', :weight => '10', :group => '0')
  menus.insert(:text => 'Etiquette', :target => '/etiquette', :parent => '2', :secure => '0', :weight => '15', :group => '0')

end
