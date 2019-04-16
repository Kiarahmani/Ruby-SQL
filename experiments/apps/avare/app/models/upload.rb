require 'spreadsheet'

class Upload < ActiveRecord::Base
  belongs_to :contractor, :class_name => "User"

  validates :entity,            :presence => true,  :length => { :minimum => 1, :maximum => 100 }
  validates :unit,                                  :length => { :minimum => 0, :maximum => 10  }    
  validates :quantity,          :presence => true, :numericality => { :greather_then_or_equal => 0.0 } 
  validates :price_with_vat,    :presence => true, :numericality => { :greather_then_or_equal => 0.0 } 
  validates :coast_of_delivery, :presence => true, :numericality => { :greather_then_or_equal => 0.0 } 
  validates :supplier,          :length => { :maximum => 100 }
  validates :master_project,    :length => { :maximum => 100 }
  validates :slave_project,     :length => { :maximum => 100 }

public
  def self.ImportFromXLS(datafile, current_user)
    book = Spreadsheet.open datafile
    sheet = book.worksheet 0
    sheet.each 1 do |row|
      break if row[0].blank?
      Upload.create! :entity => cell_data(row[1]), 
        :unit => cell_data(row[2]), 
        :quantity => cell_data(row[3]), 
        :price_with_vat => cell_data(row[4]), 
        :coast_of_delivery => cell_data(row[5]),
        :supplier => cell_data(row[6]), 
        :master_project => cell_data(row[7]), 
        :slave_project => cell_data(row[8]),
        :contractor => current_user
    end
  #rescue  
  end
  
private
  def self.cell_data(cell)
    if cell.kind_of? Spreadsheet::Formula
      cell.value
    else
      cell
    end
  end
end
