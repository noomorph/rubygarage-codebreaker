class Game
  attr_reader :chosen, :attempts_left

  ERR_TOO_LONG       = "Code is too long. Try any 4 digits from 1 to 6."
  ERR_TOO_SHORT      = "Code is too short. Try any 4 digits from 1 to 6."
  ERR_INVALID_DIGITS = "Code contains invalid digits. You can only use 123456."
  ERR_ONLY_DIGITS    = "Code should contain only digits from 1 to 6."
  ERR_MUST_BE_STRING = "Code is expected to be String, but was "
  CODE_LENGTH = 4

  def initialize(randomizer)
    @randomizer = randomizer
    reset
  end

  def reset
    @chosen = @randomizer.generate
    @attempts_left = 4
  end

  def guess(code)
    validate! code
    decrease_attempts_left

    answer = []

    code.each_char.each_with_index do |digit, index|
      if @chosen[index] == digit
        answer.push "+" 
      elsif @chosen.include? digit
        answer.push "-" 
      end
    end

    answer.sort.join
  end

  private

  def decrease_attempts_left
    if @attempts_left > 0
      @attempts_left -= 1
    end
  end

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
