require "./spec_helper"

describe Game do
    it "creates a game with an answer and moves" do
        Game.new().moves.class.should eq(Array(Tuple(Int32, Int32, Int32, Int32)))
        Game.new().answer.class.should eq(Tuple(Int32, Int32, Int32, Int32))
    end

    it "creates a game with an explicit answer" do
        Game.new({1, 2, 3, 4}).answer.should eq({1, 2, 3, 4})
    end

    it "creates a random answer with four answers between 1 and 6" do
        answer = Game.new().answer

        answer.each do |peg|
            (peg < 7).should be_true
            (peg > 0).should be_true
        end
    end

    it "should make a move" do
        Game
            .new({1, 1, 1, 2})
            .move({1, 2, 3, 2})
            .moves.size.should eq(1)

        Game.new({1, 1, 1, 2})
            .move({1, 2, 3, 2})
            .move({1, 2, 3, 3})
            .moves.size.should eq(2)

        Game.new({1, 1, 1, 2})
            .move({1, 2, 3, 2})
            .move({1, 2, 3, 3})
            .moves.last.should eq({1, 2, 3, 3})
    end
end
