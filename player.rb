class Player

  attr_reader :shape
  attr_reader :dead
  attr_writer :dead

  attr_reader :offset

  def initialize(window)
    @window = window
    @x = 321 ; @y = 278 ; @imgId = 0; @width = @height = 56
    # Offset-a Chipmunk (fisika liburutegia) eta Gosu (2D liburutegia)
    # koordenatuak berdinak izateko erabiltzen da
    @offset = 28 #jokalariaren irudiaren tamainaren erdia

    #Jokalariaren irudiak
    @left = Gosu::Image.load_tiles("img/player_left.png", @width, @height)
    @right = Gosu::Image.load_tiles("img/player_right.png", @width, @height)
    @deadImg = Gosu::Image.new("img/hurt.png")
    @shoot = Gosu::Image.new("img/shoot.png")
    @imgMaxPos = 39 #Irudi-sortaren azken posizioa

    @dead = false
    @direc = :stop

    #Kolisioak lortzeko body bat sortu behar dugu lehenengo
    @body = CP::Body::new(10, INFINITY)
    @body.p = CP::Vec2.new(@x - @offset, @y - @offset)

    #Kolisioentzako bektore karratua
    @shape_verts = [
                    CP::Vec2.new(-(@width / 2.0) + 15, (@height / 2.0) - 15),
                    CP::Vec2.new((@width / 2.0) - 15, (@height / 2.0) - 15),
                    CP::Vec2.new((@width / 2.0) - 15, -(@height / 2.0) + 15),
                    CP::Vec2.new(-(@width / 2.0) + 15, -(@height / 2.0) + 15),
                   ]

    #Kolisioak shape batekin kontrolatuko dira, body-ra itsatsita dagoena
    #Aurreko bektoreak kolisioaren limiteak izango dira
    @shape = CP::Shape::Poly.new(@body, @shape_verts, CP::Vec2.new(0,0))
    @shape.e = 0
    @shape.u = 0
    @shape.group = 3
    @shape.collision_type = :player

    #Body-a eta shape-a jokoan sartuko ditugu
    @window.space.add_body(@body)
    @window.space.add_shape(@shape)

  end

  #Funtzio honetan jokalariaren irudiak errendatuko dira tick/think bakoitzean
  def draw
    if !@dead
      if @direc == :right
        @right[@imgId/10].draw(@shape.body.p.x - @offset, @y, 3)
      elsif @direc == :left
        @left[@imgId/10].draw(@shape.body.p.x - @offset, @y, 3)
      else
        @shoot.draw(@shape.body.p.x - @offset, @y, 3)
      end
    else
      @deadImg.draw(@shape.body.p.x - @offset, @y, 3)
      #Bolak jokalariarekin jotzen ez jarraitzeko fisikak ezabatuko ditugu
      @window.space.remove_body(@body)
      @window.space.remove_shape(@shape)
    end
  end

  #Funtzio honetan jokalariaren mugimendua simulatzen da
  #Irudi-sorta batean posizioa aldatzen
  def move(direc)
    if !@dead
      @direc = direc
        if @direc == :right
          @shape.body.p.x += 2
        elsif @direc == :left
          @shape.body.p.x -= 2
        end
        @imgId += 1
        if @imgId > @imgMaxPos
          @imgId = 0
        end
      end
  end
end
