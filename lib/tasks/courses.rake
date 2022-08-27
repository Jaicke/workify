require 'fileutils'
require 'csv'

namespace :workify do
  namespace :courses do
    desc "Loads all courses from data/courses.csv"
    task load: :environment do
      if Course.table_exists?
        base_path = Rails.root.join('data')
        input_path = File.join(base_path, 'courses.csv')

        CSV.open(input_path, 'r').each do |row|
          name = row.last
          Course.find_or_create_by(name: name.titleize)
        end

        puts "tfsports:courses:load - courses loaded with success."
      else
        puts "tfsports:courses:load - courses table doesn't exists."
      end
    end
  end
end
