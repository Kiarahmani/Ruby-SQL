class Confidence < ActiveRecord::Base

  validates_presence_of :name, :weight, :account_id
  validates_uniqueness_of :name, :scope => :account_id, :case_sensitive => false
  validates_numericality_of :weight, :only_integer => true
  validates_inclusion_of :weight, :in => 0..100, :message => "must be from 0 to 100."

  belongs_to :account
  # has_many :opportunities
  
  
  def self.defaults(account)  
    account.confidences.build({:name => 'Low',     :description => "You're not likely to get the order.", :weight => 25})
    account.confidences.build({:name => 'Medium',  :description => "You may get the order.",             :weight => 50})
    account.confidences.build({:name => 'High',    :description => "You're likely to get the order.",    :weight => 75})
    account.confidences.build({:name => 'Book It', :description => "You're sure you'll get the order.",  :weight => 90})
  end

end
