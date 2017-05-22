require 'chipmunk'

require_relative 'ball'
require_relative 'brick'

class Levels

  def self.getSpace()
    space = CP::Space.new
    space.gravity = CP::Vec2.new(0, 1)
    return space
  end

  def self.level(window, num)
    balls = []
    bricks = []

    case num
      when 1
        balls.push(Ball.new(window, 50, 100, 1, 1))
      when 2
        balls.push(Ball.new(window, 20, 100, 1, 1))
        balls.push(Ball.new(window, 300, 100, 1, -1))
      when 3
        balls.push(Ball.new(window, 300, 100, 2, -1))
        balls.push(Ball.new(window, 120, 100, 2, 1))
        bricks.push(Brick.new(window, 100, 150))
        bricks.push(Brick.new(window, 450, 150))
    end

    return balls, bricks
  end
end
