# frozen_string_literal: true

class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    return unless @contact.invalid?

    @contact = Contact.new
    redirect_to action: 'new'
  end

  def back
    @contact = Contact.new(contact_params)
    render :new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to done_contacts_path
    else
      @contact = Contact.new
      redirect_to action: 'new'
    end
  end

  def done; end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message)
  end
end
