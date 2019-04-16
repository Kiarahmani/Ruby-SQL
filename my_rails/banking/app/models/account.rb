class Account < ActiveRecord::Base
  validates :balance, numericality: { greater_than: 0}
end
