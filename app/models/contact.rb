class Contact < ActiveRecord::Base
  validates_presence_of :name, :email, :number
  
  def name=(s)
    write_attribute(:name, s.to_s.titleize) # The to_s is in case you get nil/non-string
  end

end