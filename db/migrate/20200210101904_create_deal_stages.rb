class CreateDealStages < ActiveRecord::Migration[6.0]
  def change
    create_table :deal_stages do |t|
      t.integer :external_id, index: true
      t.string :name
      t.integer :percent, index: true

      t.timestamps
    end
  end
end
