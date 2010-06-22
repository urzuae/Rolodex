class Contact < ActiveRecord::Base
  belongs_to :group
  validates_presence_of :title
end
