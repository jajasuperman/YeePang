require 'gosu'
require_relative 'player'

class YeePang < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "YeePang Jokoa"
    #self.fullscreen = false

    @font = Gosu::Font.new(20)

    @player = Player.new
  end

  def update
    if Gosu.button_down? Gosu::KB_RIGHT
      @player.move(:right)
    elsif Gosu.button_down? Gosu::KB_LEFT
      @player.move(:left)
    end
  end

  def draw
    @player.draw
    @font.draw("YeePang Jokoa", 10, 10, 0.1, 1.0, 1.0, Gosu::Color::YELLOW)
  end
end

YeePang.new.show
