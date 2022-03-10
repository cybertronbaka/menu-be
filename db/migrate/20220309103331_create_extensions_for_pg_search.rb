class CreateExtensionsForPgSearch < ActiveRecord::Migration[6.1]
  def change
    execute <<-SQL
      CREATE extension IF NOT EXISTS fuzzystrmatch;
      CREATE extension IF NOT EXISTS pg_trgm;
    SQL
  end
end
