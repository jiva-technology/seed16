class HoboMigration3 < ActiveRecord::Migration
  def self.up
    add_column :invitations, :state, :string
    add_column :invitations, :key_timestamp, :datetime
  end

  def self.down
    remove_column :invitations, :state
    remove_column :invitations, :key_timestamp
  end
end
