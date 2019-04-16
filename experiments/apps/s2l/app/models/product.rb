class Product < ActiveRecord::Base
  
  belongs_to :account
  has_many :line_items
  
  def self.defaults(account)  
    
    account.products.build({:name => 'Hardware',    :description => "Tools, machinery, and other durable equipment: 'tanks and other military hardware'."})
    account.products.build({:name => 'Software',    :description => "The programs and other operating information used by a computer."})
    account.products.build({:name => 'Services',    :description => "Intangible products such as accounting, banking, cleaning, consultancy, education, insurance, expertise, medical treatment, or transportation."})
    account.products.build({:name => 'Maintenance', :description => "Activities required or undertaken to conserve as nearly, and as long, as possible the original condition of an asset or resource while compensating for normal wear and tear."})
    account.products.build({:name => 'Other',       :description => "Items falling outside the normally offered products."})
  end

end
