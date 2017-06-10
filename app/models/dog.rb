class Dog < ApplicationRecord
  validates :name, :breed, :genre, :birth, :owner_name, :owner_phone, :last_visit, presence: true
  validates :castrated, inclusion: { in: [ true, false ] }
end
