module Codebreaker
  class Code
    attr_accessor :value

    def initialize(value)
      @value = value
    end

    def compare_to(guess)
      answer = []

      guess.each_char.each_with_index do |digit, index|
        if @value[index] == digit
          answer.push "+" 
        elsif @value.include? digit
          answer.push "-" 
        end
      end

      answer.sort.join
    end
  end
end
