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
    time = 60

    case num
      when 1
        balls.push(Ball.new(window, 50, 100, 1, 1))
        time = 30
      when 2
        balls.push(Ball.new(window, 20, 100, 1, 1))
        balls.push(Ball.new(window, 300, 100, 1, -1))
      when 3
        balls.push(Ball.new(window, 300, 100, 2, -1))
        balls.push(Ball.new(window, 120, 100, 2, 1))
        bricks.push(Brick.new(window, 100, 150, ""))
        bricks.push(Brick.new(window, 450, 150, "time"))
      when 4
        balls.push(Ball.new(window, 300, 100, 4, 1))
        balls.push(Ball.new(window, 400, 150, 4, -1))
        balls.push(Ball.new(window, 30, 200, 4, 1))
        balls.push(Ball.new(window, 50, 130, 4, -1))
        balls.push(Ball.new(window, 120, 100, 4, 1))
        balls.push(Ball.new(window, 170, 10, 4, 1))
        balls.push(Ball.new(window, 90, 76, 4, -1))
        balls.push(Ball.new(window, 350, 196, 4, 1))
        balls.push(Ball.new(window, 320, 54, 4, -1))
        balls.push(Ball.new(window, 200, 93, 4, 1))
        time = 70
      when 5
        bricks.push(Brick.new(window, 100, 150, ""))
        bricks.push(Brick.new(window, 150, 200, "time"))
        bricks.push(Brick.new(window, 200, 250, ""))
        bricks.push(Brick.new(window, 550, 150, ""))
        bricks.push(Brick.new(window, 500, 200, ""))
        bricks.push(Brick.new(window, 450, 250, "heart"))

        balls.push(Ball.new(window, 50, 100, 1, 1))
    end

    return balls, bricks, time
  end
end
