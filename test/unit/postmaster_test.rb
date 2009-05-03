require 'test_helper'

class PostmasterTest < ActionMailer::TestCase
  test "contact_response" do
    @expected.subject = 'Postmaster#contact_response'
    @expected.body    = read_fixture('contact_response')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Postmaster.create_contact_response(@expected.date).encoded
  end

  test "contact_send" do
    @expected.subject = 'Postmaster#contact_send'
    @expected.body    = read_fixture('contact_send')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Postmaster.create_contact_send(@expected.date).encoded
  end

end
