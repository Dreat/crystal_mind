alias Move = Tuple(Int32, Int32, Int32, Int32)
class Game
    property answer : Move, moves : Array(Move)

    def initialize()
        @answer = Game.generate_random_answer()

        @moves = [] of Move
    end

    def initialize(answer : Move)
        @answer = answer

        @moves = [] of Move
    end

    def move(move : Move)
        moves << move
        self
    end

    def red_count(move)
        answer
            .zip(move)
            .select { |x, y| x == y}
            .size
    end

    def misses(move)
        (answer.to_a - move.to_a).size
    end

    def white_count(move)
        total_possible_pegs - red_count(move) - misses(move)
    end

    def total_possible_pegs
        answer.size
    end

    def self.generate_random_answer()
        r = Random.new

        {r.rand(1..6), r.rand(1..6), r.rand(1..6), r.rand(1..6)}
    end
end

