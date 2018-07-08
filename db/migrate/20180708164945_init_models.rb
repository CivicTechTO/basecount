class InitModels < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.string :code
      t.string :description

      t.timestamps
    end

    create_table :roles do |t|
      t.string :name
      t.string :code

      t.timestamps
    end

    create_table :permissions_roles do |t|
      t.belongs_to :permission, index: true
      t.belongs_to :role, index: true
    end

    create_table :role_scopes do |t|
      # todo
      t.belongs_to :user, index: true
      t.belongs_to :shelter, index: true
      t.belongs_to :role, index: true
      t.belongs_to :org, index: true

      t.timestamps
    end

    create_table :shelters do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :postal_code
      t.string :description
      t.decimal :lat, {:precision=>10, :scale=>6}
      t.decimal :lng, {:precision=>10, :scale=>6}

      t.belongs_to :org, index: true

      t.timestamps
    end

    create_table :orgs do |t|
      t.string :name
      t.string :description
      t.string :subdomain

      t.timestamps
    end

    create_table :population_whitelists do |t|
      t.integer :code
      t.belongs_to :shelter, index: true

      t.timestamps
    end

    create_table :aspects do |t|
      t.string :name

      t.timestamps
    end

    create_table :shelters_aspects do |t|
      t.belongs_to :shelter, index: true
      t.belongs_to :aspect, index: true
    end


    create_table :schedules do |t|
      t.belongs_to :shelter, index: true
      t.datetime :open
      t.datetime :close

      t.timestamps
    end


    create_table :schedule_templates do |t|
      t.belongs_to :shelter, index: true
      t.integer :day_of_week
      t.integer :open
      t.integer :close

      t.timestamps
    end

    create_table :rooms do |t|
      t.belongs_to :shelter, index: true
      t.integer :capacity

      t.timestamps
    end

    create_table :historical_capacities do |t|
      t.belongs_to :room
      t.belongs_to :recorded_by, class_name: 'User'
      t.datetime :recorded_at
      t.integer :capacity
      t.integer :total

      t.timestamps
    end

  end
end
