class Event < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title       :string
    description :text
    website     :string
    timestamps
  end

  belongs_to :organizer, :class_name => "User"
  has_many :invitations

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up? ||
    acting_user.administrator?
  end

  def update_permitted?
    organizer_is?(acting_user) ||
    acting_user.administrator?
  end

  def destroy_permitted?
    organizer_is?(acting_user) ||
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
