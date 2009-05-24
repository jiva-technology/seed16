class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string   :title
      t.text     :description
      t.string   :website
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :organizer_id
    end
    
    create_table :invitations do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :event_id
      t.integer  :sender_id
      t.integer  :recipient_id
      t.string   :state
      t.datetime :key_timestamp
    end
    
    create_table :users do |t|
      t.string   :crypted_password, :limit => 40
      t.string   :salt, :limit => 40
      t.string   :remember_token
      t.datetime :remember_token_expires_at
      t.string   :name
      t.string   :email_address
      t.boolean  :administrator, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :state, :default => "active"
      t.datetime :key_timestamp
    end
  end

  def self.down
    drop_table :events
    drop_table :invitations
    drop_table :users
  end
end
