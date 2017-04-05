require 'gosu'
require 'chipmunk'

require_relative 'player'
require_relative 'ball'
require_relative 'wall'

SCREEN_WIDTH = 640
SCREEN_HEIGHT = 480
INFINITY = 1.0/0

class YeePang < Gosu::Window

  attr_accessor :space

  def initialize
    super 640, 480
    self.caption = "YeePang Jokoa"
    #self.fullscreen = false

    @font = Gosu::Font.new(20)

    @space = CP::Space.new
    @space.gravity = CP::Vec2.new(0, 1)
    @dt = (1.0/60.0)

    @player = Player.new

    @star = Star.new(self)

    @wall0 = Wall.new(self, 13, 13, SCREEN_WIDTH - 13, 0)       # up
    @wall1 = Wall.new(self, 13, 347 - 13, SCREEN_WIDTH - 13, 0) # down
    @wall2 = Wall.new(self, 13, 13, 0, 347 - 13)                # left
    @wall3 = Wall.new(self, SCREEN_WIDTH - 13, 13, 0, 347 - 13) # right

    @back = Gosu::Image.load_tiles("img/back.png", 640, 347)
  end

  def update
    if Gosu.button_down? Gosu::KB_RIGHT
      @player.move(:right)
    elsif Gosu.button_down? Gosu::KB_LEFT
      @player.move(:left)
    end
    10.times do
      @space.step(@dt)
    end
  end

  def draw
    @back[0].draw(0, 0, 1, 1)
    @player.draw
    @star.draw
    @font.draw("YeePang Jokoa", 10, 10, 0.1, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end

end

YeePang.new.show
