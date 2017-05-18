class Harpoon

  attr_reader :y

  def initialize(window, x)
    @window = window

    @x = x
    @y = 300

    @width = 16
    @height = 321

    @img = Gosu::Image.load_tiles("img/harpoon.png", @width, @height)
    @imgNum = 0
    @imgNumMax = 19
  end

  def draw
    @img[@imgNum/10].draw(@x, @y, 2)
  end

  def update
    @y = @y - 3
    @imgNum += 2
    if @imgNum > @imgNumMax
      @imgNum = 0
    end
  end

end
