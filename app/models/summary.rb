class Summary < ActiveRecord::Base
  belongs_to :user

  has_attached_file :before, styles: { big: "1000x1000>", thumb: "200x200>" }
  validates_attachment_content_type :before, content_type: /\Aimage\/.*\Z/
  has_attached_file :after, styles: { big: "1000x1000>", thumb: "200x200>" }
  validates_attachment_content_type :after, content_type: /\Aimage\/.*\Z/
  has_attached_file :motivation, styles: { big: "1000x1000>", thumb: "200x200>" }
  validates_attachment_content_type :motivation, content_type: /\Aimage\/.*\Z/
  
end
