class Lightning < ActiveRecord::Base
   enum status: [ :active, :paid, :authorized]
end
