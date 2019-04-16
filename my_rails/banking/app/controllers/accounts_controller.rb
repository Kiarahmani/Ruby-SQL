class AccountsController < ApplicationController


  def show 
    @accounts = Account.all
  end
 
  def my_func (amount)
    @all_acs = Account.all
    @kia_acs = Account.where(owner: 'Kia')
    @ac1 = @kia_acs.first
    if @ac1.balance >= @amount
    then @ac1.balance = @ac1.balance - @amount 
    end
  end
 

end
