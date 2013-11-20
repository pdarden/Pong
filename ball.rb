class Ball
  SIZE = 50

  attr_reader :x, :y, :angle, :speed
  def initialize(window)
    @x = Pong::WIDTH/2
    @y = Pong::HEIGHT/2

    # Starting angle
    @angle = rand(120) + 30
    # @angle *= -1 if rand > 0.5
    @speed = 6
    @img = Gosu::Image.new(window, "./Nyan_cat.png", false)
  end

  def dx; Gosu.offset_x(angle, speed); end
  def dy; Gosu.offset_y(angle, speed); end

  def move!
    # Updates the cordinate when the ball moves!
    @x += dx
    @y += dy

    # Make the ball bounce from the top
    if @y < 43
      @y = 43
      bounce_off_edge!
    end

    # Make the ball bounce from the bottom
    if @y > Pong::HEIGHT + 15
      @y = Pong::HEIGHT + 15
      bounce_off_edge!
    end
  end

  def bounce_off_edge!
    @angle = Gosu.angle(0, 0, dx, -dy)
  end

  def x1; @x - SIZE/2; end
  def x2; @x + SIZE/2; end
  def y1; @y - SIZE/2; end
  def y2; @y + SIZE/2; end

  def intersect?(paddle)
    x1 < paddle.x2 &&
      x2 > paddle.x1 &&
      y1 < paddle.y2 &&
      y2 > paddle.y1
  end

  ##Draw the ball
  def draw(window, orientation)
    @img.draw_rot(x1, y1, 5, 0, 0.7, 0.7, orientation)

    # color = @img.draw(0,0,0)
    # color = Gosu::Color::BLUE

    # window.draw_quad(
    #   x1, y1, color,
    #   x1, y2, color,
    #   x2, y2, color,
    #   x2, y1, color
    #   )
  end

  def off_left?
    x1 < 0
  end

  def off_right?
    x2 > Pong::WIDTH
  end

  def bounce_off_paddle!(paddle)
    case paddle.side
    when :left
      @x = paddle.x2 + SIZE/2
    when :right
      @x = paddle.x1 - SIZE/2
    end

    ratio = (y - paddle.y) / Paddle::HEIGHT
    @angle = ratio * 90 + 90
    @angle *= -1 if paddle.side == :right

    @speed *= 1.1

  end
end
