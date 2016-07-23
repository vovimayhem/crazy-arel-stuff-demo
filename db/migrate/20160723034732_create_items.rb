class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.references :inbound_log, null: false, foreign_key: true

      t.references :product, null: false, foreign_key: true
      t.jsonb :properties, null: false, default: "{}"

      t.references :shelf, null: true
      t.integer :rank, null: true

      t.references :outbound_log, null: true, foreign_key: true

      t.timestamps
    end
  end
end
