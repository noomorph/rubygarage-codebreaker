module Codebreaker
  class Randomizer
    def generate
      4.times.map { Random.rand(1..6) }.join
    end
  end
end
