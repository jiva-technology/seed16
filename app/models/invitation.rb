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
  
    create :invite, :params => [ :recipient ], :become => :invited,
      :available_to => "User", :user_becomes => :sender do
      InvitationMailer.send recipient, "#{sender.name} has invited you to..."
    end
  
    transition :retract, { :invited => :destroy }, :available_to => :sender do
      InvitationMailer.send recipient, "#{sender.name} has retracted your invitation. Too slow."
    end
  
    transition :accept, { :invited => :accepted }, :available_to => :recipient do
      InvitationMailer.send sender, "#{recipient.name} has accepted your invitation. Hooray."
    end
  
    transition :decline, { :invited => :destroy }, :available_to => :recipient do
      InvitationMailer.send sender, "#{recpient.name} has declined your invitation. Boo."
    end
  
    transition :decline, { :accepted => :destroy }, :available_to => :recipient do
      InvitationMailer.send sender, "#{recipient.name} has declined your invitation after all. Boo."
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
