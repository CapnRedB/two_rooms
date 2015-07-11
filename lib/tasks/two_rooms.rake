namespace :two_rooms do
  desc "Dump data to seed file, uses rroblak/seed_dump with custom options"
  task dump: :environment do

    tables = [:cards, :card_relationships, :rounds, :swaps]
    options = { file: 'db/seeds.rb', append: true, exclude: [:created_at, :updated_at]}

    File.open('db/seeds.rb', 'w') do |f|
      tables.each do |table|
        f.puts "ActiveRecord::Base.connection.execute(\"TRUNCATE TABLE #{table.to_s} RESTART IDENTITY;\")"
      end
    end

    tables.each do |table|
      SeedDump.dump(table.to_s.classify.constantize.unscoped, options)
    end
  end

end
