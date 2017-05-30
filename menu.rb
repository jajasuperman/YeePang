class Menu

  def initialize
    @logo = Gosu::Image.new("img/logo.png")
    @imgOption = Gosu::Image.new("img/b3.png")
    @soundSelect1 = Gosu::Sample.new("sound/select1.wav")
    @soundSelect2 = Gosu::Sample.new("sound/select2.wav")
    @option = 1

    @menu_color = Gosu::Color.argb(0xff_ffff6f)
  end

  def update
    if @option > 2
      @option = 1
    elsif @option < 1
      @option = 2
    end
  end

  def draw

    @logo.draw(SCREEN_WIDTH / 2 - @logo.width / 2, 100, 1)

    $font.draw("Play", 250, 250, 1, 1.0, 1.0, @menu_color )
    $font.draw("Exit", 250, 300, 1, 1.0, 1.0, @menu_color )

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
      if @option == 1
        @soundSelect2.play()
        YeePang.changeState(:game)
      elsif @option == 2
        exit
      end
    end
  end

end
