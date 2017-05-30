class DropItem

  attr_reader :shape
  attr_reader :type

  def initialize(space, x, y, type)

    @img = Gosu::Image.new("img/"+ type + ".png")

    @type = type

    body = CP::Body::new(1, INFINITY)
    body.p = CP::Vec2.new(x, y)

    shape_verts = [
                    CP::Vec2.new(-(@img.width / 2.0), (@img.height / 2.0)),
                    CP::Vec2.new((@img.width / 2.0), (@img.height / 2.0)),
                    CP::Vec2.new((@img.width / 2.0), -(@img.height / 2.0)),
                    CP::Vec2.new(-(@img.width / 2.0), -(@img.height / 2.0)),
                   ]

    @shape = CP::Shape::Poly.new(body, shape_verts, CP::Vec2.new(0,0))
    @shape.e = 0
    @shape.u = 0
    @shape.layers = 2
    @shape.group = 4
    @shape.collision_type = :dropItem

    space.add_body(body)
    space.add_shape(@shape)
  end

  def draw
    @img.draw(@shape.body.p.x - (@img.width / 2.0), @shape.body.p.y - (@img.height / 2.0), 2)
  end

end
