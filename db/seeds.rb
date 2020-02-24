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
CSV.foreach(Rails.root.join('python/2000_first_animes_02_14_2020_safer_separator.csv'), headers: true) do |row|
    # Start at 1 because of index column in csv
    alternative_names = row[4]&.split('emilientaip') || []
    # TODO: add uniqueness in each model
    unless Anime.where(name: row[1]).exists?
        Anime.create!({name: row[1], image_file_name: row[2], rank: row[3], alternative_names: alternative_names})
    end
end

CSV.foreach(Rails.root.join('python/2000_animes_openings_23_02_2020.csv'), headers: true) do |row|
    # Start at 1 because of index column in csv
    music = Music.new({name: row[3], youtube_video_id: row[1], type: :opening})
    # TODO: change anime ids, so dirty
    music.anime = Anime.find(row[2].to_i + 8235)
    music.save!
end

CSV.foreach(Rails.root.join('python/2000_animes_osts_23_02_2020.csv'), headers: true) do |row|
    # Start at 1 because of index column in csv
    music = Music.new({name: row[3], youtube_video_id: row[1], type: :ost})
    # TODO: change anime ids, so dirty
    music.anime = Anime.find(row[2].to_i + 8235)
    music.save!
end