# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# coding: utf-8
StudyAbroad.delete_all
Teacher.delete_all
#User
User.create(:name => 'Uchikawa')
User.create(:name => 'Sarunyoo')
User.create(:name => 'Sato')

# StudyAbroad関係
StudyAbroad.create(:school_name => 'CNE1', :study_from => '2011-01-01', :study_to => '2011-02-01', :user_id => 4)
StudyAbroad.create(:school_name => 'StoryShare', :study_from => '2012-01-01', :study_to => '2012-02-01', :user_id => 4)
StudyAbroad.create(:school_name => 'ああああ', :study_from => '2010-01-01', :study_to => '2010-02-01', :user_id => 4)

# Teacher関連
Teacher.create(:name => 'Jackie', :study_abroads_id => 4)
Teacher.create(:name => 'Via', :study_abroads_id => 4)
Teacher.create(:name => 'Apple', :study_abroads_id => 5)
Teacher.create(:name => 'Garry', :study_abroads_id => 5)

Prefecture.create(:name => '北海道')
Prefecture.create(:name => '青森')
Prefecture.create(:name => '秋田')
Prefecture.create(:name => '岩手')
Prefecture.create(:name => '宮城')