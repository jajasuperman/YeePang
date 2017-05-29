require 'gosu'

require_relative 'menu'
require_relative 'game'

SCREEN_WIDTH = 640
SCREEN_HEIGHT = 480

$font = nil
$currentState = nil

class YeePang < Gosu::Window

  def initialize
    super SCREEN_WIDTH, SCREEN_HEIGHT
    self.caption = "YeePang Jokoa"

    $currentState = Menu.new()

    $font = Gosu::Font.new(self, "./font/ARCADECLASSIC.TTF", 30)
  end

  def update
    $currentState.update()
  end

  def draw
    $currentState.draw()
  end

  def button_down(id)
    $currentState.button_down(id)
  end

  def self.changeState(state)
    if state == :game
      $currentState = Game.new()
    elsif state == :menu
      $currentState = Menu.new()
    end
  end
end

YeePang.new.show
