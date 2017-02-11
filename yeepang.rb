require 'gosu'

class Tutorial < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "YeePang Jokoa"

	@font = Gosu::Font.new(20)
  end

  def update
  end

  def draw
        @font.draw("YeePang Jokoa", 10, 10, 0.1, 1.0, 1.0, Gosu::Color::YELLOW)
  end
end

Tutorial.new.show