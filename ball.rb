class Ball

  attr_reader :shape

  attr_accessor :x
  attr_accessor :y

  attr_reader :size

  def initialize(window, x, y, size, direc)
    @size = size

    #Tamaina desberdineko bolak sortuko dira
    if @size == 1
      @animation = Gosu::Image.new("img/b1.png")
    elsif @size == 2
      @animation = Gosu::Image.new("img/b2.png")
    elsif @size == 3
      @animation = Gosu::Image.new("img/b3.png")
    else
      @animation = Gosu::Image.new("img/b4.png")
    end

    #Fisikak ezartzeko body bat sortu beharko dugu
    body = CP::Body.new(10, INFINITY)
    body.p = CP::Vec2.new(x, y)
    body.v = CP::Vec2.new(6*direc, -10)

    #Shape-ak fisikak emango dizkigu bolentzako
    @shape = CP::Shape::Circle.new(body,
                                   @animation.width / 2,
                                   CP::Vec2.new(0,0))
    @shape.e = 1
    @shape.u = 0
    @shape.group = 4
    @shape.collision_type = :ball

    #Fisikak jokoan sartuko ditugu
    window.space.add_body(body)
    window.space.add_shape(@shape)
  end

  def x
    @shape.body.p.x
  end
  def y
    @shape.body.p.y
  end

  #Funtzio honek bolak errendatuko ditu jokoan
  def draw
    @animation.draw(@shape.body.p.x - @animation.width / 2.0, @shape.body.p.y - @animation.height / 2.0, 2)
  end

end
