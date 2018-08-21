class AlignSiteToWireframes < ActiveRecord::Migration[5.2]
  
  def up
    rename_table :sites_aspects, :aspects_sites
    change_table :sites do |t|
      t.boolean "active", default: true
      t.string :populations
      t.string "phone"
      t.rename :address1, :address
      t.rename :description, :services

      t.remove :lat, :decimal, precision: 10, scale: 6
      t.remove :lng, :decimal, precision: 10, scale: 6
      t.remove :address2
      t.remove :city
    end

    drop_table :population_whitelists
  end

  def down
    rename_table :aspects_sites, :sites_aspects
    change_table :sites do |t|
      t.remove :active
      t.remove :phone
      t.rename :address, :address1
      t.rename :services, :description
      t.remove :populations

      t.string :address2
      t.string :city
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
    end

    create_table :population_whitelists do |t|
      t.integer :code
      t.belongs_to :site, index: true

      t.timestamps
    end
  end
end
