class InvitationMailer < ActionMailer::Base
  
  def invite(invitation, sent_at = Time.now)
    subject    "Invitation to #{invitation.event.title}"
    recipients invitation.recipient.email_address
    from       invitation.sender.email_address
    sent_on    sent_at
    
    body       :event => invitation.event, 
               :sender => invitation.sender, 
               :recipient => invitation.recipient,
               :key => invitation.lifecycle.key

    @host = Hobo::Controller.request_host
  end

  def retract(invitation, sent_at = Time.now)
    subject    "Retracted invitation to #{invitation.event.title}"
    recipients invitation.recipient.email_address
    from       invitation.sender.email_address
    sent_on    sent_at
    
    body       :event => invitation.event, 
               :sender => invitation.sender, 
               :recipient => invitation.recipient,
               :id => invitation.id
  end

  def accept(invitation, sent_at = Time.now)
    subject    "Accepted invitation to #{invitation.event.title}"
    recipients invitation.sender.email_address
    from       invitation.recipient.email_address
    sent_on    sent_at
    
    body       :event => invitation.event, 
               :sender => invitation.sender, 
               :recipient => invitation.recipient,
               :key => invitation.lifecycle.key,
               :id => invitation.id
  end

  def decline(invitation, sent_at = Time.now)
    subject    "Declined invitation to #{invitation.event.title}"
    recipients invitation.sender.email_address
    from       invitation.recipient.email_address
    sent_on    sent_at
    
    body       :event => invitation.event, 
               :sender => invitation.sender, 
               :recipient => invitation.recipient,
               :key => invitation.lifecycle.key,
               :id => invitation.id
  end

end
