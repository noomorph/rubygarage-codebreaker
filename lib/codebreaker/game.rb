require "codebreaker/code"

class Game
  attr_reader :chosen, :attempts_left

  def initialize(randomizer, validator)
    @randomizer, @validator = randomizer, validator
    reset
  end

  def reset
    @chosen = Codebreaker::Code.new(@randomizer.generate)
    @attempts_left = 4
  end

  def guess(code)
    @validator.validate! code
    decrease_attempts_left
    @chosen.compare_to code
  end

  private

  def decrease_attempts_left
    if @attempts_left > 0
      @attempts_left -= 1
    end
  end
end
