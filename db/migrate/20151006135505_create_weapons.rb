class CreateWeapons < ActiveRecord::Migration
  def up
    create_table :weapons do |t|
      t.string :name
      t.text :description
      t.string :rarity
      t.string :weapon_type
      t.integer :bungie_id
    end
  end

  def down
    drop_table :weapons
  end
end
