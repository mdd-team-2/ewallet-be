class MddTransaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :transaction_type
end
