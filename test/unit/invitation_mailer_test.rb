require 'test_helper'

class InvitationMailerTest < ActionMailer::TestCase
  test "invite" do
    @expected.subject = 'InvitationMailer#invite'
    @expected.body    = read_fixture('invite')
    @expected.date    = Time.now

    assert_equal @expected.encoded, InvitationMailer.create_invite(@expected.date).encoded
  end

  test "retract" do
    @expected.subject = 'InvitationMailer#retract'
    @expected.body    = read_fixture('retract')
    @expected.date    = Time.now

    assert_equal @expected.encoded, InvitationMailer.create_retract(@expected.date).encoded
  end

  test "accept" do
    @expected.subject = 'InvitationMailer#accept'
    @expected.body    = read_fixture('accept')
    @expected.date    = Time.now

    assert_equal @expected.encoded, InvitationMailer.create_accept(@expected.date).encoded
  end

  test "decline" do
    @expected.subject = 'InvitationMailer#decline'
    @expected.body    = read_fixture('decline')
    @expected.date    = Time.now

    assert_equal @expected.encoded, InvitationMailer.create_decline(@expected.date).encoded
  end

end
