class Contact < ActiveRecord::Base
  belongs_to :group
  belongs_to :list
  has_one :contact_photo
  validates_presence_of :name
  #has_attached_file :photo, :styles => { :thumb=> "100x100#" }
  #validates_attachment_presence :photo
  
  def self.listing(list)
    results = ""
    list.contacts.each do |f|
      results += f.name
    end
    return results
  end
end
