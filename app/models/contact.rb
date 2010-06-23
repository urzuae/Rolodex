class Contact < ActiveRecord::Base
  belongs_to :group
  validates_presence_of :name
  
  def self.listing
    results = ""
    Contact.all.each do |f|
      results += f.name
    end
    return results
  end
end
