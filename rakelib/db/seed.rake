# frozen_string_literal: true

namespace :db do
  desc 'Seeds database'
  task seed: :settings do
    filename = File.expand_path('../../db/seeds.rb', __dir__)
    load(filename) if File.exist?(filename)
  end
end
