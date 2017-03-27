class Player
  def initialize
    @x = 16 ; @y = 400 ; @imgId = 0
    @walk = Gosu::Image.load_tiles("img/player.png", 32, 32)
    @direc = :right
  end

  def draw
    if @direc == :right
      factor = 1.0
      dif = -16
    else
      factor = -1.0
      dif = 16
    end
    @walk[@imgId/10].draw(@x + dif, @y, 1, factor)
  end

  def move(direc)
    @direc = direc
    if @direc == :right
      @x += 2
    else
      @x -= 2
    end
    @imgId = @imgId + 1
    if @imgId > 39
      @imgId = 0
    end
  end

end
