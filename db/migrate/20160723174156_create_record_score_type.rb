class CreateRecordScoreType < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE TYPE \"record_score\" AS " \
            "(\"id\" NUMERIC, \"score\" NUMERIC(8,4))"
  end

  def down
    execute "DROP TYPE IF EXISTS \"record_score\""
  end
end
