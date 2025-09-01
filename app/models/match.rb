class Match < ApplicationRecord
  belongs_to :matcher, class_name: "User"
  belongs_to :matched, class_name: "User"
end
