# frozen_string_literal: true

class BirthdayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if valid_birthday?(value)

    record.errors.add attribute, (options[:message] || 'is not valid')
  end

  private

  def valid_birthday?(birthday)
    return false if birthday.blank?

    age = Date.today.year - birthday.year
    age.between?(1, 120)
  end
end
