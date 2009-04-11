class Address < ActiveRecord::Base
  has_many :shipments
end
