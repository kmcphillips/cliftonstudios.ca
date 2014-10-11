class Link < ActiveRecord::Base
  include Audited

  validates :url, :presence => true, :uniqueness => true
  validate :url_begins_with_protocol

  scope :sorted, ->{ order("sort_order ASC, created_at DESC") }

  def display
    title.blank? ? url : title
  end

  protected

  def url_begins_with_protocol
    errors.add(:url, "must begin with 'http://' or 'https://'") unless url =~ /http(s)?:\/\/.+/
  end

end
