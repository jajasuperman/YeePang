require 'chipmunk'

require_relative 'player'
require_relative 'wall'
require_relative 'harpoon'
require_relative 'levels'

INFINITY = 1.0/0

class Game

  attr_accessor :space

  def initialize
    @space = Levels.getSpace()

    @dt = (1.0/60.0)

    @player = Player.new(self)

    @levelNum = 3
    @liveNum = 3
    @killed = false
    @balls, @bricks = Levels.level(self, @levelNum)

    @ballToRemove = nil

    @wall0 = Wall.new(self, 13, 13, SCREEN_WIDTH - 13, 0)       # up
    @wall1 = Wall.new(self, 13, 347 - 13, SCREEN_WIDTH - 13, 0) # down
    @wall2 = Wall.new(self, 13, 13, 0, 347 - 13)                # left
    @wall3 = Wall.new(self, SCREEN_WIDTH - 13, 13, 0, 347 - 13) # right

    @harpoon = nil
    @time = nil

    @back = Gosu::Image.load_tiles("img/back.png", 640, 347)
    @back2 = Gosu::Image.new("img/back2.png")

    @space.add_collision_func(:player, :ball) do
      @player.dead = true
    end
    @space.add_collision_func(:harpoon, :ball) do |harpoon, ballShape|
      @ballToRemove = ballShape
    end

  end

  def restart_level
    @space.remove_body(@player)
    @space.remove_shape(@player)
    @killed = false

    @space = Levels.getSpace()

    @dt = (1.0/60.0)

    @player = Player.new(self)

    @balls, @bricks = Levels.level(self, @levelNum)

    @ballToRemove = nil

    @harpoon = nil
    @time = nil
  end



  def update
    if Gosu.button_down? Gosu::KB_RIGHT and (@time == nil or Time.now.to_i > @time + 0.5)
      @player.move(:right)
    elsif Gosu.button_down? Gosu::KB_LEFT and (@time == nil or Time.now.to_i > @time + 0.5)
      @player.move(:left)
    else
      @player.move(:stop)
    end

    10.times do
      @space.step(@dt)
    end

    if @player.dead == true
      if !@killed
        @liveNum = @liveNum - 1
        if @liveNum == 0
          exit
        end
        restart_level()
      end
      @killed = true
      @space.remove_body(@player.shape.body)
      @space.remove_shape(@player.shape)
      @balls.each do |b|
        @space.remove_body(b.shape.body)
        @space.remove_shape(b.shape)
      end
    end

    if @harpoon != nil
      @harpoon.update()

      if @harpoon.shape.body.p.y <= 179
        @space.remove_body(@harpoon.shape.body)
        @space.remove_shape(@harpoon.shape)
        @harpoon = nil
      end

      if @ballToRemove != nil
        ball = @balls.detect { |ball| ball.shape == @ballToRemove }
        @balls.delete(ball)
        @space.remove_body(ball.shape.body)
        @space.remove_shape(ball.shape)
        @ballToRemove = nil

        if(ball.size != 4)
          @balls.push(Ball.new(self, ball.x - 10, ball.y, ball.size + 1, -1))
          @balls.push(Ball.new(self, ball.x + 10, ball.y, ball.size + 1, 1))
        end

        if @harpoon != nil
          @space.remove_body(@harpoon.shape.body)
          @space.remove_shape(@harpoon.shape)
          @harpoon = nil
        end
      end

      if @balls.empty?
        @levelNum += 1
        @balls, @bricks = Levels.level(self, @levelNum)
      end
    end

    if Gosu.button_down? Gosu::KB_SPACE
      if @harpoon == nil
        @time = Time.now.to_i
        @harpoon = Harpoon.new(self, @player.shape.body.p.x)
        @player.move(:stop)
      end
    end

    if Gosu.button_down? Gosu::KB_ESCAPE
      exit
    end
  end

  def draw
    @back[@levelNum-1].draw(0, 0, 1)
    @back2.draw(13, 0, 3)
    @player.draw

    @balls.each do |b| b.draw end
    @bricks.each do |b| b.draw end

    if @harpoon != nil
      @harpoon.draw()
    end
  end

  def button_down(id)
  end

end
