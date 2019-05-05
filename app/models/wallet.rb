class Wallet < ApplicationRecord

  def self.has_money(id, amount)
    @wallet = Wallet.where(user_id: id)
    if !@wallet.empty?
      @wallet = @wallet.first
      return @wallet.current_value >= amount
    else
      return false
    end
  end

  def self.get_money(id, amount)
    @wallet = Wallet.where(user_id: id)
    if !@wallet.empty?
      @wallet = @wallet.first
      @wallet.current_value -= amount
      if @wallet.save
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def self.current_money(id)
    @wallet = Wallet.where(user_id: id)
    if !@wallet.empty?
      @wallet = @wallet.first
      return @wallet.current_value
    else
      return false
    end
  end

  def self.give_money(id, amount)
    @wallet = Wallet.find(id)
    if @wallet
      @wallet.current_value += amount
      if @wallet.save
        return true
      else
        return false
      end
    else
      return false
    end
  end

end
