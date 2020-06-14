# frozen_string_literal: true

namespace :db do
  desc 'Run database migrations'
  task :migrate, %i[version] => :settings do |_t, args|
    require 'sequel/core'
    Sequel.extension :migration

    Sequel.connect(Settings.db.to_hash) do |db|
      db.extension :schema_dumper
      migrations = File.expand_path('../../db/migrations', __dir__)
      version = args.version.to_i if args.version

      Sequel::Migrator.run(db, migrations, target: version)

      File.open 'db/schema.rb', 'w' do |file|
        file << db.dump_schema_migration(same_db: true)
      end
    end
  end

  desc 'Create database'
  task create: :settings do
    require 'sequel/core'
    Sequel.connect(Settings.db.to_hash.merge(database: 'postgres')) do |db|
      dataset = db["SELECT 1 FROM pg_database WHERE datname = '#{Settings.db.to_hash[:database]}'"]
      if dataset.first.nil?
        db.run("CREATE DATABASE #{Settings.db.to_hash[:database]}")
        puts "Database #{Settings.db.to_hash[:database]} was successfully created."
      else
        puts "Database #{Settings.db.to_hash[:database]} already exists."
      end
    end
  end
end
