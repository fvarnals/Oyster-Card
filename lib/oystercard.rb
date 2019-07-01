require 'money'


class Oystercard
   DEFAULT_MAX_BALANCE = 90

  attr_accessor :balance, :max_balance, :money

  def initialize(balance = 0, max_balance = DEFAULT_MAX_BALANCE)
    @balance = balance
    @max_balance = max_balance
    # @money = money
  end

  def top_up(money)
    raise 'Max top up allowed is £90. Please select different amount' if money + balance > DEFAULT_MAX_BALANCE
    @balance += money
  end

  # private
  #
  # def max(money, balance)
  #   money + balance > DEFAULT_MAX_BALANCE
  # end
end
