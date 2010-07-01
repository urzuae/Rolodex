class Contact < ActiveRecord::Base
  belongs_to :group
  belongs_to :list
  validates_presence_of :name
  
  def self.listing(list)
    results = ""
    list.contacts.each do |f|
      results += f.name
    end
    return results
  end
end
