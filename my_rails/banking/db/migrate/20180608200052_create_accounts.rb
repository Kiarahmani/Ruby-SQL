class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :id
      t.string :owner
      t.integer :balance

      t.timestamps
    end
  end
end
