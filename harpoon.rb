class Harpoon

  attr_reader :shape

  attr_reader :x
  attr_reader :y
  attr_reader :width
  attr_reader :height

  def initialize(window, x)
    @window = window

    @x = x
    @y = 450

    @width = 16
    @height = 321

    @img = Gosu::Image.load_tiles("img/harpoon.png", @width, @height)
    @imgNum = 0
    @imgNumMax = 19

    #Kolisioak lortzeko body bat sortu behar dugu lehenengo
    @body = CP::Body::new(1, INFINITY)
    @body.p = CP::Vec2.new(@x, @y)
    @body.v = CP::Vec2.new(0, -15)
    @body.f = CP::Vec2.new(0, -1)

    #Kolisioentzako bektore karratua
    @shape_verts = [
                    CP::Vec2.new(-(@width / 2.0), (@height / 2.0)),
                    CP::Vec2.new((@width / 2.0), (@height / 2.0)),
                    CP::Vec2.new((@width / 2.0), -(@height / 2.0)),
                    CP::Vec2.new(-(@width / 2.0), -(@height / 2.0)),
                   ]

    #Kolisioak shape batekin kontrolatuko dira, body-ra itsatsita dagoena
    #Aurreko bektoreak kolisioaren limiteak izango dira
    @shape = CP::Shape::Poly.new(@body, @shape_verts, CP::Vec2.new(0,0))
    @shape.e = 0
    @shape.u = 0
    @shape.group = 3
    @shape.layers = 1
    @shape.collision_type = :harpoon

    #Body-a eta shape-a jokoan sartuko ditugu
    @window.space.add_body(@body)
    @window.space.add_shape(@shape)
  end

  def draw
    @img[@imgNum/10].draw(@shape.body.p.x - (@width / 2), @shape.body.p.y - (@height / 2), 2)
  end

  def update
    @imgNum += 2
    if @imgNum > @imgNumMax
      @imgNum = 0
    end
  end

end
