require "bundler/setup"
require "hasu"

Hasu.load "ball.rb"
Hasu.load "paddle.rb"

class Pong < Hasu::Window
  WIDTH = 768
  HEIGHT = 576

  # Width and height of the game's window
  def initialize
    super(WIDTH, HEIGHT, false)
    @song = Gosu::Song.new(self, "./Nyan\ Cat.mp3")
    @song.play(true)
  end

  def reset
    @orientation = 1
    @ball = Ball.new(self)

    @left_score = 0
    @right_score = 0

    @font = Gosu::Font.new(self, "Arial", 30)

    @left_paddle = Paddle.new(:left, false)
    @right_paddle = Paddle.new(:right)
  end

  def draw
    @ball.draw(self, @orientation)

    @font.draw(@left_score, 30, 30, 0)
    @font.draw(@right_score, WIDTH-50, 30, 0)

    @left_paddle.draw(self)
    @right_paddle.draw(self)
  end

  # '!' will delete the previous ball and draw a new ball
  # Makes the ball moves.
  def update
    @ball.move!

    if @left_paddle.ai?
      @left_paddle.ai_move!(@ball)
    else
      # Button_down ask if the key is pressed.
      # Use 'W' on the keyboard to make paddle go up.
      if button_down?(Gosu::KbW)
        @left_paddle.up!
      end
      # Use 'S' on the keyboard to make paddle go down.
      if button_down?(Gosu::KbS)
        @left_paddle.down!
      end
    end

    if button_down?(Gosu::KbUp)
      @right_paddle.up!
    end

    if button_down?(Gosu::KbDown)
      @right_paddle.down!
    end

    # Makes ball bounce off the paddle.
    if @ball.intersect?(@left_paddle)
      @orientation = 1
      @ball.bounce_off_paddle!(@left_paddle)
    end

    if @ball.intersect?(@right_paddle)
      @orientation = -1
      @ball.bounce_off_paddle!(@right_paddle)
    end

    # Update the scores if the ball goes off screen
    # and reset the ball
    if @ball.off_left?
      @right_score += 1
      @ball = Ball.new(self)
      @orientation = 1
    end

    if @ball.off_right?
      @left_score += 1
      @ball = Ball.new(self)
    end
  end

  def button_down(button)
    case button
    when Gosu::KbEscape
      close
    end
  end

end

Pong.run
