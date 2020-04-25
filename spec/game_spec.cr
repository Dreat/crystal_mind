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

    it "should count red pegs" do
        Game.new({1, 2, 3, 4}).red_count({1, 2, 3, 4}).should eq(4)
        Game.new({1, 2, 3, 4}).red_count({1, 2, 4, 5}).should eq(2)
        Game.new({1, 1, 1, 2}).red_count({1, 1, 1, 1}).should eq(3)
    end

    it "should count white pegs" do
        Game.new({1, 2, 3, 4}).white_count({1, 2, 3, 4}).should eq(0)
        Game.new({1, 2, 3, 4}).white_count({1, 2, 4, 5}).should eq(1)
        Game.new({1, 1, 1, 2}).white_count({2, 2, 2, 1 }).should eq(4)
    end

    it "should count winners and losers" do
        game = Game.new({1, 1, 1, 2}).move({1, 2, 3, 2})

        game.won?.should_not be_true
        Game.new.won?.should_not be_true
        Game.new.lost?.should_not be_true

        won_game = Game.new({1, 1, 1, 1}).move({1, 1, 1, 1})
        won_game.won?.should be_true
        won_game.lost?.should_not be_true

        lost_game = Game.new({1, 1, 1, 1})
            .move({2, 2, 2, 2})
            .move({2, 2, 2, 2})
            .move({2, 2, 2, 2})
            .move({2, 2, 2, 2})
            .move({2, 2, 2, 2})
            .move({2, 2, 2, 2})
            .move({2, 2, 2, 2})
            .move({2, 2, 2, 2})
            .move({2, 2, 2, 2})
            .move({2, 2, 2, 2})

        lost_game.lost?.should be_true
        lost_game.won?.should_not be_true
    end
end

