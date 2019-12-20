class UserLike < ApplicationRecord
    belongs_to :liker, class_name: 'User'
    belongs_to :likee, class_name: 'User'
end
