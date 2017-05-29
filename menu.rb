class Menu

  def initialize
    @imgOption = Gosu::Image.new("img/b3.png")
    @soundSelect1 = Gosu::Sample.new("sound/select1.wav")
    @soundSelect2 = Gosu::Sample.new("sound/select2.wav")
    @option = 1
  end

  def update
    if @option > 2
      @option = 1
    elsif @option < 1
      @option = 2
    end
  end

  def draw
    $font.draw("Play", 250, 250, 1, 1.0, 1.0, Gosu::Color::YELLOW)
    $font.draw("Options", 250, 300, 1, 1.0, 1.0, Gosu::Color::YELLOW)

    if @option == 1
      @imgOption.draw(225, 255, 1)
    else
      @imgOption.draw(225, 305, 1)
    end

    $font.draw("jajasuperman & thadah - 2017", 200, 450, 1, 0.5, 0.5, Gosu::Color::YELLOW)
  end

  def button_down(id)
    if id == Gosu::KB_UP
      @soundSelect1.play()
      @option += 1
    elsif id == Gosu::KB_DOWN
      @soundSelect1.play()
      @option -= 1
    end

    if id == Gosu::KB_RETURN
      @soundSelect2.play()
      YeePang.changeState(:game)
    end
  end

end
