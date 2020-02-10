class CreateDeals < ActiveRecord::Migration[6.0]
  def change
    create_table :deals do |t|
      t.integer :external_id, index: true
      
      t.string :name
      t.integer :deal_stage_id, index: true
      t.decimal :value, precision: 10, scale: 2

      t.timestamps
    end
  end
end
