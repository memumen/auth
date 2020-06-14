# frozen_string_literal: true

namespace :generate do
  desc 'Generate migration'
  task :migration do
    ARGV.each { |a| task a.to_sym }
    abort('Missing migration file name') if ARGV[1].nil?
    name = ARGV[1].dup.gsub!(/(.)([A-Z])/, '\1_\2').downcase!
    migrations = File.expand_path('../../db/migrations', __dir__)
    timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    filename = File.join(migrations, "#{timestamp}_#{name}.rb")
    str = <<~STR
      # frozen_string_literal: true

      Sequel.migration do
        change do
        end
      end
    STR
    File.write(filename, str)
    puts "Generated migration: #{timestamp}_#{name}.rb"
  end
end
