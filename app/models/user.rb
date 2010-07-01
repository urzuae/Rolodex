class User < ActiveRecord::Base
  has_one :list
  acts_as_authentic

end
