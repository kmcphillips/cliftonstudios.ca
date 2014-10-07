class Document < ActiveRecord::Base

  include Audited
  include EmailOnCreate

  KINDS = ['bylaw'].freeze

  belongs_to :member

  has_attached_file :file,
    whiny: true,
    path: ":rails_root/public/assets/documents/:filename",
    url: "/assets/documents/:filename"

  validates :name, presence: true
  validates :kind, inclusion: {in: KINDS}
  validates_attachment_size :file, in: 1..10.megabytes
  validates_attachment_presence :file

  scope :sorted, order('name DESC')

  def bylaw?
    kind == 'bylaw'
  end

end
