class Letter < ApplicationRecord
  validates :letter_text, presence: true
end
