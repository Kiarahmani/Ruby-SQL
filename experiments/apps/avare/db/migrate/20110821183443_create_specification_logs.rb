class CreateSpecificationLogs < ActiveRecord::Migration
  def self.up
    create_table :specification_logs do |t|
      t.integer :specification_id
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
      t.timestamps
    end
  end

  def self.down
    drop_table :specification_logs
  end
end
