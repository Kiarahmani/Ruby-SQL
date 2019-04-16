class CreateSpecifications < ActiveRecord::Migration
  def self.up
    create_table :specifications do |t|
      t.string :entity
      t.string :unit
      t.float :quantity
      t.float :price_with_vat
      t.float :coast_of_delivery
      t.integer :category_id      
      t.string :supplier
      t.integer :project_id
      t.string :notice
      t.string :recommended_conditions
      t.string :recommended_supplier
      t.string :recommended_notice
      t.integer :contractor_id
      t.integer :controller_id
      t.string :state
      
      t.datetime :state_switched_at
      t.integer :studying_duration
      t.integer :approving_duration
      
      t.timestamps
    end
  end

  def self.down
    drop_table :specifications
  end
end
