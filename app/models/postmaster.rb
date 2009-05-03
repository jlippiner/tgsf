class Postmaster < ActionMailer::Base
  

  def contact_response(sent_at = Time.now)
    subject    'Postmaster#contact_response'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

  def contact_send(sent_at = Time.now)
    subject    'Postmaster#contact_send'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
