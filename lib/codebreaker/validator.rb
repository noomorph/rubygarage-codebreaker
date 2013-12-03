module Codebreaker

  class Validator

    ERR_TOO_LONG       = "Code is too long. Try any 4 digits from 1 to 6."
    ERR_TOO_SHORT      = "Code is too short. Try any 4 digits from 1 to 6."
    ERR_ONLY_DIGITS    = "Code should contain only digits from 1 to 6."
    ERR_INVALID_DIGITS = "Code contains invalid digits. You can only use 123456."
    ERR_MUST_BE_STRING = "Code is expected to be String, but was "
    CODE_LENGTH = 4

    def validate!(code)
      if not code.is_a? String
        raise TypeError.new("#{ERR_MUST_BE_STRING} #{code.class}.")
      elsif /[^\d]+/.match(code)
        raise ArgumentError.new ERR_ONLY_DIGITS
      elsif /[0789]+/.match(code)
        raise ArgumentError.new ERR_INVALID_DIGITS
      elsif code.length > CODE_LENGTH
        raise ArgumentError.new ERR_TOO_LONG
      elsif code.length < CODE_LENGTH
        raise ArgumentError.new ERR_TOO_SHORT
      end
    end
  end

end
