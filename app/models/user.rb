class User < ApplicationRecord
  has_secure_password

  validetes :email, presence: true

end
