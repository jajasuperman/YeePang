require 'chipmunk'

require_relative 'player'
require_relative 'wall'
require_relative 'harpoon'
require_relative 'dropItem'
require_relative 'levels'

INFINITY = 1.0/0

class Game

  attr_accessor :space

  def initialize
    @space = Levels.getSpace()

    @dt = (1.0/60.0)

    @player = Player.new(self)

    @levelNum = 1
    @liveNum = 3
    @killed = false
    @balls, @bricks, @gameTime = Levels.level(self, @levelNum)
    @dropItems = []
    @t1 = Time.now.to_i

    @wall0 = Wall.new(self, 13, 13, SCREEN_WIDTH - 13, 0)       # up
    @wall1 = Wall.new(self, 13, 347 - 13, SCREEN_WIDTH - 13, 0) # down
    @wall2 = Wall.new(self, 13, 13, 0, 347 - 13)                # left
    @wall3 = Wall.new(self, SCREEN_WIDTH - 13, 13, 0, 347 - 13) # right

    @harpoon = nil
    @moveTime = nil

    @back = Gosu::Image.load_tiles("img/back.png", 640, 347)
    @back2 = Gosu::Image.new("img/back2.png")

    @pop = Gosu::Sample.new("sound/pop.wav")

    @space.add_collision_func(:player, :ball) do
      kill_player()
    end
    @space.add_collision_func(:harpoon, :ball) do |harpoon, ballShape|
      @pop.play()
      @ballToRemove = ballShape
    end
    @space.add_collision_func(:harpoon, :brick) do |harpoon, brickShape|
      @brickToRemove = brickShape
    end
    @space.add_collision_func(:player, :dropItem) do |player, dropShape|
      @dropToRemove = dropShape
    end
  end

  def restart_level
    @player = Player.new(self)

    @balls, @bricks, @gameTime = Levels.level(self, @levelNum)

    @ballToRemove = nil
    @dropItems = []

    @killed = false
    @moveTime = nil
    @t1 = Time.now.to_i
    @t2 = nil
  end

  def kill_player
    @player.dead = true
    if !@killed
      @liveNum = @liveNum - 1
      @timeDead = Time.now.to_i
    end
    @killed = true
  end

  def update
    if Gosu.button_down? Gosu::KB_RIGHT and (@moveTime == nil or Time.now.to_i > @moveTime + 0.4)
      @player.move(:right)
    elsif Gosu.button_down? Gosu::KB_LEFT and (@moveTime == nil or Time.now.to_i > @moveTime + 0.4)
      @player.move(:left)
    else
      @player.move(:stop)
    end

    10.times do
      @space.step(@dt)
    end

    if @player.dead == true
      @space.remove_body(@player.shape.body)
      @space.remove_shape(@player.shape)

      @balls.each do |b|
        @space.remove_body(b.shape.body)
        @space.remove_shape(b.shape)
      end
      @bricks.each do |b|
        @space.remove_body(b.shape.body)
        @space.remove_shape(b.shape)
      end
      @dropItems.each do |b|
        @space.remove_body(b.shape.body)
        @space.remove_shape(b.shape)
      end

      @harpoon = nil

      if Time.now.to_i > @timeDead + 3
        if @liveNum <= 0
          YeePang.changeState(:menu)
        end
        @player.dead = false
        restart_level()
      end
    end

    if @harpoon != nil
      @harpoon.update()

      if @harpoon.shape.body.p.y <= 179
        @space.remove_body(@harpoon.shape.body)
        @space.remove_shape(@harpoon.shape)
        @harpoon = nil
      end

      if @brickToRemove != nil
        brick = @bricks.detect { |brick| brick.shape == @brickToRemove }
        @bricks.delete(brick)
        @space.remove_static_shape(brick.shape)
        @brickToRemove = nil

        if @harpoon != nil
          @space.remove_body(@harpoon.shape.body)
          @space.remove_shape(@harpoon.shape)
          @harpoon = nil
        end
        if brick.drop != ""
          @dropItems.push(DropItem.new(@space, brick.x, brick.y, brick.drop))
        end
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
        if @levelNum <= 5
          @levelNum += 1
          @balls, @bricks, @gameTime = Levels.level(self, @levelNum)
        else
          YeePang.changeState(:menu)
        end
      end
    end

    if @dropToRemove != nil
      drop = @dropItems.detect { |drop| drop.shape == @dropToRemove }
      @dropItems.delete(drop)
      @space.remove_body(drop.shape.body)
      @space.remove_shape(drop.shape)
      @dropToRemove = nil
      if drop.type == "time"
        @gameTime += 10
      elsif drop.type == "heart"
        @liveNum += 1
      end
    end

    if Gosu.button_down? Gosu::KB_SPACE
      if !@player.dead
        if @harpoon == nil
          @moveTime = Time.now.to_i
          @harpoon = Harpoon.new(self, @player.shape.body.p.x)
          @player.move(:stop)
        end
      end
    end

    if Gosu.button_down? Gosu::KB_ESCAPE
      exit
    end

    if !@player.dead
      @t2 = Time.now.to_i
      delta = @t2 - @t1
      if delta > 1 and @gameTime > 0
        @t1 = Time.now.to_i
        @gameTime -= 1
        if @gameTime == 0
          kill_player()
        end
      end
    end
  end

  def draw
    @back[@levelNum-1].draw(0, 0, 1)
    @back2.draw(13, 0, 3)
    @player.draw()

    @balls.each do |b| b.draw end
    @bricks.each do |b| b.draw end
    @dropItems.each do |b| b.draw end

    if @harpoon != nil
      @harpoon.draw()
    end

    $font.draw("Life: " + @liveNum.to_s, 150, 400, 3, 1.0, 1.0, Gosu::Color::YELLOW)
    $font.draw("Time: " + @gameTime.to_s, 150, 430, 3, 1.0, 1.0, Gosu::Color::YELLOW)

    $font.draw("Level " + @levelNum.to_s, 400, 415, 3, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def button_down(id)
  end

end
