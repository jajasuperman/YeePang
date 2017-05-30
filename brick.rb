class Brick

  attr_reader :shape
  attr_reader :x
  attr_reader :y
  attr_reader :drop

  def initialize(window, x, y, drop)

    @drop = drop

    @img = Gosu::Image.new("img/brick1.png")

    body = CP::Body.new_static()
    body.p = CP::Vec2.new(x, y)


    shape_verts = [
                    CP::Vec2.new(-(@img.width / 2.0), (@img.height / 2.0)),
                    CP::Vec2.new((@img.width / 2.0), (@img.height / 2.0)),
                    CP::Vec2.new((@img.width / 2.0), -(@img.height / 2.0)),
                    CP::Vec2.new(-(@img.width / 2.0), -(@img.height / 2.0)),
                   ]

    @shape = CP::Shape::Poly.new(body, shape_verts, CP::Vec2.new(0,0))
    @shape.e = 1
    @shape.u = 0
    @shape.collision_type = :brick

    window.space.add_static_shape(@shape)
  end

  def x
    @shape.body.p.x
  end
  def y
    @shape.body.p.y
  end

  def draw
    @img.draw(@shape.body.p.x - (@img.width / 2.0), @shape.body.p.y - (@img.height / 2.0), 2)
  end

end
