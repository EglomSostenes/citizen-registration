# frozen_string_literal: true

class CnsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if valid_cns?(value)

    record.errors.add attribute, (options[:message] || 'is not valid')
  end

  private

  def remove_special_characters(cns)
    cns.gsub!(/[^\d]/, '')
  end

  def valid_cns?(cns)
    return false if cns.blank?

    remove_special_characters(cns)
    return false if cns.size != 15

    ((0..14).sum { |i| cns[i].to_i * (15 - i) } % 11).zero?
  end
end
