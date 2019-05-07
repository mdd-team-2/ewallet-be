class Payment < ApplicationRecord
  belongs_to :service
  belongs_to :mddtransaction

end
