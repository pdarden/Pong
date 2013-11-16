require "bundler/setup"
require "hasu"

Hasu.load "ball.rb"

class Pong < Hasu::Window
  WIDTH = 768
  HEIGHT = 576

  # Width and height of the game's window
  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset
    @ball = Ball.new
  end

  def draw
    @ball.draw(self)
  end

  # '!' will delete the previous ball and draw a new ball
  # Makes the ball moves
  def update
    @ball.move!
  end

end

Pong.run
