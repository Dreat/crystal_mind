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

    def self.generate_random_answer()
        r = Random.new

        {r.rand(1..6), r.rand(1..6), r.rand(1..6), r.rand(1..6)}
    end
end

