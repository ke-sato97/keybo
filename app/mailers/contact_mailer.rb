class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail to: 'ke.sato97@gmail.com', subject: '【お問い合わせ】' + @contact.subject
    # mail to: ENV['MAIL_ADDRESS'], subject: '【お問い合わせ】' + @contact.subject
  end
end
