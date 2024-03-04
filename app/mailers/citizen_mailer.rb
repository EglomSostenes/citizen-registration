# frozen_string_literal: true

class CitizenMailer < ApplicationMailer
  default from: 'citizen-registration-suporte@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.citizen_mailer.registration_notification.subject
  #
  def registration_notification(citizen_full_name, citizen_email)
    @name = citizen_full_name.split.first

    mail(to: citizen_email, subject: 'Registo de munícipe')
  end

  def change_status_notification(citizen_full_name, citizen_email)
    @name = citizen_full_name.split.first

    mail(to: citizen_email, subject: 'Seu status foi alterado na plataforma de registro de munícipes.')
  end
end
