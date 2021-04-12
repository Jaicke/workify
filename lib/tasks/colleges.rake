require 'fileutils'
require 'csv'

namespace :tcc do
  namespace :colleges do
    desc "Loads all colleges from data/colleges.csv"
    task load: :environment do
      if College.table_exists?
        base_path = Rails.root.join('data')
        input_path = File.join(base_path, 'colleges.csv')

        CSV.open(input_path, 'r').each do |row|
          name, acronym, state = row
          College.find_or_create_by(name: name.titleize, acronym: acronym, state: state)
        end

        puts "tfsports:colleges:load - Colleges loaded with success."
      else
        puts "tfsports:colleges:load - Colleges table doesn't exists."
      end
    end
  end
end
