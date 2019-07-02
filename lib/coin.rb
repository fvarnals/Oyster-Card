require 'pry'
class Coin
  attr_accessor :coin, :score

  def initialize(coin = "coin")
   @coin = coin
   @score = []
  end

  def flip
   toss = rand(1..2)
   if toss == 1
     score.push("tails")
   elsif toss == 2
     score.push("heads")
   end
 end

  def result
   score.count("heads")
  end

end

binding.pry
