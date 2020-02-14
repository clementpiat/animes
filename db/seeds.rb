# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# See special character case: Incorrect string value: '\xCE\xA8-nan...' 'Saiki Kusuo no Ψ-nan 2'
# Solution: Manually fix the CSV
# Better solution: FIXED go to dbeaver, animes_development, name column, and change the encoding from utf8 to utf8mb4
# TODO: find a way to specify charset in the migration
CSV.foreach(Rails.root.join('python/2000_first_animes_02_13_2020.csv'), headers: true) do |row|
    # Start at 1 because of index column in csv
    Anime.create!({name: row[1], image_file_name: row[2], rank: row[3]})
end
