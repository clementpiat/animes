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
CSV.foreach(Rails.root.join('data/animes_sample.csv'), headers: false) do |row|
    alternative_names = row[3]&.split('random_sep') || []
    unless Anime.where(name: row[0]).exists?
        Anime.create({name: row[0], image_file_name: row[1], rank: row[2], alternative_names: alternative_names})
    end
end

CSV.foreach(Rails.root.join('data/osts_sample.csv'), headers: false) do |row|
    # Start at 1 because of index column in csv
    music = Music.new({name: row[2], youtube_video_id: row[0], type: :ost})
    # TODO: change anime ids, so dirty
    music.anime = Anime.find(row[1].to_i)
    music.save
end