class Star

  attr_reader :shape

  def initialize(window)
    @window = window
    @font = Gosu::Font.new(20)

    @animation = Gosu::Image.new("img/b1.png")

    @color = Gosu::Color.new(0xff_000000)
    @color.red = rand(255 - 40) + 40
    @color.green = rand(255 - 40) + 40
    @color.blue = rand(255 - 40) + 40

    @body = CP::Body.new(10, INFINITY)
    @body.p = CP::Vec2.new(100, 200)
    @body.v = CP::Vec2.new(6, 0)

    @shape_verts = [
                    CP::Vec2.new(-(@animation.width / 2.0), (@animation.height / 2.0)),
                    CP::Vec2.new((@animation.width / 2.0), (@animation.height / 2.0)),
                    CP::Vec2.new((@animation.width / 2.0), -(@animation.height / 2.0)),
                    CP::Vec2.new(-(@animation.width / 2.0), -(@animation.height / 2.0)),
                   ]

    @shape = CP::Shape::Poly.new(@body,
                                 @shape_verts,
                                 CP::Vec2.new(0,0))

    @shape.e = 1
    @shape.u = 0

    @window.space.add_body(@body)
    @window.space.add_shape(@shape)
  end

  def draw
    @animation.draw(@shape.body.p.x - @animation.width / 2.0, @shape.body.p.y - @animation.height / 2.0, 2)
    @font.draw(@shape.body.p.y, 300, 10, 0.1, 1.0, 1.0, Gosu::Color::YELLOW)
  end
  
end
