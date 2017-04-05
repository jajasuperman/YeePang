class Player

  def initialize
    @x = 321 ; @y = 278 ; @imgId = 0
    @walk = Gosu::Image.load_tiles("img/player.png", 56, 56)
    @direc = :right
  end

  def draw
    if @direc == :right
      factor = 1.0
      dif = -28
    else
      factor = -1.0
      dif = 28
    end
    @walk[@imgId/10].draw(@x + dif, @y, 1, factor)
  end

  def move(direc)
    @direc = direc
    if 41 <= @x and @x <= SCREEN_WIDTH - 41
      if @direc == :right
        @x += 2
      else
        @x -= 2
      end
    end
    if @x < 41
      @x = 41
    elsif @x > SCREEN_WIDTH - 41
      @x = SCREEN_WIDTH - 41
    end
    @imgId = @imgId + 1
    if @imgId > 39
      @imgId = 0
    end
  end

end
