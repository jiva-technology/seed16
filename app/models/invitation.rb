class Invitation < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end

  belongs_to :event
  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  # --- Invitation lifecycle --- #

  lifecycle do
  
    state :invited, :accepted
  
    create :invite, :become => :invited, :params => [:event, :recipient],
      :available_to => "User", :user_becomes => :sender, :new_key => true do
      InvitationMailer.deliver_invite self
    end
  
    transition :retract, { :invited => :destroy }, 
      :available_to => :sender do
      InvitationMailer.deliver_retract self
    end
  
    transition :accept, { :invited => :accepted },  
      :available_to => :key_holder do
      InvitationMailer.deliver_accept self
    end
  
    transition :decline, { [:invited, :accepted] => :destroy }, 
      :available_to => :key_holder do
      InvitationMailer.deliver_decline self
    end
  
  end
  
  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up? ||
    acting_user.administrator?
  end

  def update_permitted?
    sender_is?(acting_user) ||
    acting_user.administrator?
  end

  def destroy_permitted?
    sender_is?(acting_user) ||
    acting_user.administrator?  
  end

  def view_permitted?(field)
    true
  end

end
