class CreateTables < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :city
      t.string :state
    end

    create_table :shipments do |t|
      t.integer :address_id
      t.string :description
    end
  end

  def self.down
    drop_table :shipments
    drop_table :addresses
  end
end
