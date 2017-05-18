class Wall

  attr_reader :a, :b

  def initialize(window, x, y, w, h)
    @window = window

    @a = CP::Vec2.new(0,0)
    @b = CP::Vec2.new(w, h)

    @body = CP::Body.new_static()
    @body.p = CP::Vec2.new(x, y)

    @shape = CP::Shape::Segment.new(@body,
                                    @a,
                                    @b,
                                    1)
    @shape.e = 1
    @shape.u = 0

    @window.space.add_static_shape(@shape)
  end

end
