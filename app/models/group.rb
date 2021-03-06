class Group < ActiveRecord::Base
  belongs_to :list
  has_many :contacts
  validates_presence_of :title
  
  def delete_contacts
    self.contacts.each do |f|
      f.group_id = nil
    end
  end
end
