class DropRooms < ActiveRecord::Migration[5.2]
  def up
    drop_table :rooms
    
    change_table :sites do |t|
      t.integer :default_capacity
    end

    change_table :headcounts do |t|
      t.belongs_to :site, index: true
      t.remove :room_id
    end
  end

  def down
    create_table :rooms do |t|
      t.belongs_to :site, index: true
      t.integer :capacity

      t.timestamps
    end

    change_table :sites do |t|
      t.remove :default_capacity
    end

    # todo how to drop join?
    change_table :headcounts do |t|
      t.remove :site_id
      t.belongs_to :room
    end
  end
end
