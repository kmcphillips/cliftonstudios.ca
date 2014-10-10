class Document < ActiveRecord::Base

  include Audited
  include EmailOnCreate
  after_update :create_email

  KINDS = ['bylaw'].freeze

  belongs_to :member

  has_attached_file :file,
    whiny: true,
    path: ":rails_root/public/attachments/documents/:filename",
    url: "/attachments/documents/:filename"

  validates :name, presence: true
  validates :kind, inclusion: {in: KINDS}
  validates_attachment_size :file, in: 1..10.megabytes
  validates_attachment_presence :file

  scope :sorted, order('name DESC')
  scope :bylaws, where(kind: 'bylaw')

  def bylaw?
    kind == 'bylaw'
  end

end
