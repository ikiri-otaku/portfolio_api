class Like < ApplicationRecord
  include Discard::Model
  
  belongs_to :user
  belongs_to :portfolio
end
