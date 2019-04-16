class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.string :entity
      t.string :unit
      t.float :quantity
      t.float :price_with_vat
      t.float :coast_of_delivery
      t.string :supplier
      t.string :master_project
      t.string :slave_project
      t.integer :contractor_id
      t.timestamps
    end
  end

  def self.down
    drop_table :uploads
  end
end
