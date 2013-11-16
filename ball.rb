class Ball
  SIZE = 16

  attr_reader :x, :y, :angle, :speed
  def initialize
    @x = Pong::WIDTH/2
    @y = Pong::HEIGHT/2

    @angle = 45
    @speed = 4
  end

  def move!
    dx = Gosu.offset_x(angle, speed)
    dy = Gosu.offset_y(angle, speed)

    # Updates the cordinate when the ball moves!
    @x += dx
    @y += dy
  end

  def x1; @x - SIZE/2; end
  def x2; @x + SIZE/2; end
  def y1; @y - SIZE/2; end
  def y2; @y + SIZE/2; end

  ##Draw the ball
  def draw(window)
    color = Gosu::Color::RED

    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color
      )
  end
end
