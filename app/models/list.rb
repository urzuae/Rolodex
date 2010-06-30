class List < ActiveRecord::Base
  belongs_to :user
  has_many :contacts
  has_many :groups
end
