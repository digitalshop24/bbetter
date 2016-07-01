class Summary < ActiveRecord::Base
  belongs_to :user

  has_attached_file :before_front, styles: { big: "1000x1000>", thumb: "200x200>" }
  validates_attachment_content_type :before_front, content_type: /\Aimage\/.*\Z/
  has_attached_file :before_back, styles: { big: "1000x1000>", thumb: "200x200>" }
  validates_attachment_content_type :before_back, content_type: /\Aimage\/.*\Z/
  has_attached_file :before_left, styles: { big: "1000x1000>", thumb: "200x200>" }
  validates_attachment_content_type :before_left, content_type: /\Aimage\/.*\Z/
  has_attached_file :before_right, styles: { big: "1000x1000>", thumb: "200x200>" }
  validates_attachment_content_type :before_right, content_type: /\Aimage\/.*\Z/
  
  has_attached_file :after_front, styles: { big: "1000x1000>", thumb: "200x200>" }
  validates_attachment_content_type :after_front, content_type: /\Aimage\/.*\Z/
  has_attached_file :after_back, styles: { big: "1000x1000>", thumb: "200x200>" }
  validates_attachment_content_type :after_back, content_type: /\Aimage\/.*\Z/



  has_attached_file :motivation, styles: { big: "1000x1000>", thumb: "200x200>" }
  validates_attachment_content_type :motivation, content_type: /\Aimage\/.*\Z/
  
end
