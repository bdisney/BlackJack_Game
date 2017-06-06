class Bank
  attr_accessor :sum

  def initialize(holder, sum)
    @sum = sum
  end

  def money_transfer(receiver, value)
    raise 'Недостаточно средств. Игра окончена.' if sum.zero?

    self.sum -= value
    receiver.sum += value
  end
end
