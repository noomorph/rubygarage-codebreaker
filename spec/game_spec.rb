require 'spec_helper'
require 'codebreaker/game'

describe Game do

  context "when being created" do
    before(:each) { @randomizer = double(:randomizer) }

    it "requires randomizer as constructor argument" do
      expect { Game.new }.to raise_error ArgumentError
    end

    it "uses randomizer inside constructor" do
      @randomizer.should_receive(:generate)
      Game.new(@randomizer)
    end

    it "chooses number using generator" do
      @randomizer.stub(:generate).and_return "1234"
      expect(Game.new(@randomizer).chosen).to eq "1234"
    end
  end

  context "when created" do
    before :each do
      randomizer = double(:randomizer)
      randomizer.stub(:generate).and_return "1234", "2516"
      @game = Game.new(randomizer)
    end

    it "has 4 attempts left" do
      expect(@game.attempts_left).to eq 4
    end

    it "decreases attempts count after each guess" do
      @game.attempts_left.times do
        expect { @game.guess "5555" }.to change { @game.attempts_left }.by(-1)
      end
    end

    context "when guessing invalid input" do
      it "raises error when guess contains any digit = 7|8|9|0" do
        ["7123", "1823", "1293", "1230"].each do |code|
          expect { @game.guess(code) }.to raise_error ArgumentError, Game::ERR_INVALID_DIGITS
        end
      end

      it "raises error when code is too long" do
        expect { @game.guess("12345") }.to raise_error ArgumentError, Game::ERR_TOO_LONG
      end

      it "raises error when code is too short" do
        expect { @game.guess("123") }.to raise_error ArgumentError, Game::ERR_TOO_SHORT
      end

      it "raises error when string contains not only digits" do
        expect { @game.guess("A123") }.to raise_error ArgumentError, Game::ERR_ONLY_DIGITS
      end

      it "raises error when code is not a string" do
        expect { @game.guess(1234) }.to raise_error TypeError, "#{Game::ERR_MUST_BE_STRING} Fixnum."
      end
    end

    context "when guessing code" do
      it "outputs empty if total miss" do
        expect(@game.guess "5656").to eq ""
      end

      context "when guessed in right order" do
        it "outputs '++++' if everything guessed" do
          expect(@game.guess "1234").to eq "++++"
        end
        it "outputs '+++' if 1 not guessed" do
          expect(@game.guess "5234").to eq "+++"
        end
        it "outputs '++' if 2 not guessed" do
          expect(@game.guess "1536").to eq "++"
        end
        it "outputs '+' if 3 not guessed" do
          expect(@game.guess "5255").to eq "+"
        end
      end

      context "when guessed in wrong order" do
        it "outputs '----' if everything guessed" do
          expect(@game.guess "2341").to eq "----"
        end
        it "outputs '---' if 1 not guessed" do
          expect(@game.guess "5342").to eq "---"
        end
        it "outputs '---' if 2 not guessed" do
          expect(@game.guess "5621").to eq "--"
        end
        it "outputs '---' if 3 not guessed" do
          expect(@game.guess "5651").to eq "-"
        end
      end

      context "when guessed in right and wrong order" do
        it "outputs '+---' if 1 right, 3 unordered" do
          expect(@game.guess "4132").to eq "+---"
        end
        it "outputs '++--' if 2 right, 2 unordered" do
          expect(@game.guess "4134").to eq "++--"
        end
        it "outputs '+++-' if 3 right, 1 unordered" do
          expect(@game.guess "1231").to eq "+++-"
        end
        it "outputs '+-' if 1 right, 1 unordered, 2 wrong" do
          expect(@game.guess "1356").to eq "+-"
        end
      end

    end

    context "when no attempts left" do
      before(:each) { @game.attempts_left.times { @game.guess "5555" } }

      it "has zero attempt count" do
        expect(@game.attempts_left).to eq 0
      end

      it "does not decrease attempts count" do
        expect { @game.guess "5555" }.not_to change { @game.attempts_left }
      end
    end

    context "when guessed one time" do
      before(:each) { @game.guess "5555" }

      it "should change chosen code after reset" do
        expect { @game.reset }.to change { @game.chosen }.from("1234").to("2516")
      end

      it "should revert attempts count to 4 after reset" do
        expect { @game.reset }.to change { @game.attempts_left }.from(3).to(4)
      end
    end
  end
end
