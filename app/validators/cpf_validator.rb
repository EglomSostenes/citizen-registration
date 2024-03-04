# frozen_string_literal: true

class CpfValidator < ActiveModel::EachValidator
  DENY_LIST = %w[
    00000000000
    11111111111
    22222222222
    33333333333
    44444444444
    55555555555
    66666666666
    77777777777
    88888888888
    99999999999
    12345678909
    01234567890
  ].freeze

  def validate_each(record, attribute, value)
    return if valid_cpf?(value)

    record.errors.add attribute, (options[:message] || 'is not valid')
  end

  private

  def remove_special_characters(cpf)
    cpf.gsub!(/[^\d]/, '')
  end

  def valid_cpf?(cpf)
    return false if cpf.blank?

    remove_special_characters(cpf)
    return false if cpf.size != 11
    return false if DENY_LIST.include?(cpf)

    cpf_numbers = cpf.scan(/[0-9]/)
    cpf_numbers = cpf_numbers.collect(&:to_i)

    first_digit_valid?(cpf_numbers) && second_digit_valid?(cpf_numbers)
  end

  def first_digit_valid?(cpf_numbers)
    sum = (10 * cpf_numbers[0]) + (9 * cpf_numbers[1]) + (8 * cpf_numbers[2]) +
          (7 * cpf_numbers[3]) + (6 * cpf_numbers[4]) + (5 * cpf_numbers[5]) +
          (4 * cpf_numbers[6]) + (3 * cpf_numbers[7]) + (2 * cpf_numbers[8])
    sum -= (11 * (sum / 11))
    result = [0, 1].include?(sum) ? 0 : 11 - sum
    result == cpf_numbers[9]
  end

  def second_digit_valid?(cpf_numbers)
    sum = (cpf_numbers[0] * 11) + (cpf_numbers[1] * 10) + (cpf_numbers[2] * 9) +
          (cpf_numbers[3] * 8) + (cpf_numbers[4] * 7) + (cpf_numbers[5] * 6) +
          (cpf_numbers[6] * 5) + (cpf_numbers[7] * 4) + (cpf_numbers[8] * 3) + (cpf_numbers[9] * 2)
    sum -= (11 * (sum / 11))
    result = [0, 1].include?(sum) ? 0 : 11 - sum
    result == cpf_numbers[10]
  end
end
