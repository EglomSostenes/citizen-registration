class Citizen < ApplicationRecord
  enum status: %i[inactive active]

  validates_presence_of :full_name, :cpf, :cns, :email, :phone, :birthday, :status
  validates_uniqueness_of :cpf, :cns, :email, :phone
  validates :cpf, cpf: true
  validates :cns, cns: true
  validates :birthday, birthday: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_one :address

  accepts_nested_attributes_for :address

  after_save :notifies_if_status_has_changed

  def self.ransackable_attributes(_auth_object = nil)
    %w[birthday cns cpf created_at email full_name id phone status
       updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[address picture_attachment picture_blob]
  end

  private

  def notifies_if_status_has_changed
    if saved_change_to_attribute?(:status)
      CitizenMailer.change_status_notification(full_name, email).deliver_later
    end
  end
end
