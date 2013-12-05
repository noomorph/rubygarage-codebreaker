require "codebreaker/code"

module Codebreaker
  class Game
    ERR_IS_OVER = "Game is over"

    attr_reader :chosen, :attempts_left

    def initialize(randomizer, validator)
      @randomizer, @validator = randomizer, validator
      reset
    end

    def reset
      @chosen = Code.new(@randomizer.generate)
      @attempts_left = 4
    end

    def guess(code)
      @validator.validate! code
      update_attempts_left!
      @chosen.compare_to code
    end

    private

    def update_attempts_left!
      if @attempts_left > 0
        @attempts_left -= 1
      else
        raise ERR_IS_OVER
      end
    end
  end
end
