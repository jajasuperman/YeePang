class Ball

  attr_reader :shape

  def initialize(window, size)
    @window = window

    #Tamaina desberdineko bolak sortuko dira
    if size == 1
      @animation = Gosu::Image.new("img/b1.png")
    elsif size == 2
      @animation = Gosu::Image.new("img/b2.png")
    elsif size == 3
      @animation = Gosu::Image.new("img/b3.png")
    else
      @animation = Gosu::Image.new("img/b4.png")
    end

    #Kolorea jarriko diegu bolei
    @color = Gosu::Color.new(0xff_000000)
    @color.red = rand(255 - 40) + 40
    @color.green = rand(255 - 40) + 40
    @color.blue = rand(255 - 40) + 40

    #Fisikak ezartzeko body bat sortu beharko dugu
    @wallOffset = 13 #Hesiaren tamaina
    @minHeight = 222 #Bolak agertuko diren altuera minimoa
    @body = CP::Body.new(10, INFINITY)
    @body.p = CP::Vec2.new(@wallOffset + rand(SCREEN_WIDTH - @animation.width - @wallOffset), @wallOffset + rand(@minHeight - @animation.height - @wallOffset))
    @body.v = CP::Vec2.new(6, 0)

    #Shape-ak fisikak emango dizkigu bolentzako
    @shape = CP::Shape::Circle.new(@body,
                                   @animation.width / 2,
                                   CP::Vec2.new(0,0))
    @shape.e = 1
    @shape.u = 0
    @shape.group = 5
    @shape.collision_type = :ball

    #Fisikak jokoan sartuko ditugu
    @window.space.add_body(@body)
    @window.space.add_shape(@shape)
  end

  #Funtzio honek bolak errendatuko ditu jokoan
  def draw
    @animation.draw(@shape.body.p.x - @animation.width / 2.0, @shape.body.p.y - @animation.height / 2.0, 2)
  end

end
