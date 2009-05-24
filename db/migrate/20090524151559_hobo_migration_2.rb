class HoboMigration2 < ActiveRecord::Migration
  def self.up
    remove_column :invitations, :key_timestamp
    remove_column :invitations, :state
  end

  def self.down
    add_column :invitations, :key_timestamp, :datetime
    add_column :invitations, :state, :string
  end
end
