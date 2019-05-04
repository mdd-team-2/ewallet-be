class Payment < ApplicationRecord
  belongs_to :service
  belongs_to :transaction
end
