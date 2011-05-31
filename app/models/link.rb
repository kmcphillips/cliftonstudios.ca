class Link < ActiveRecord::Base
  validates :url, :presence => true, :uniqueness => true
  validate :url_begins_with_protocol

  scope :sorted, order("created_at DESC")

  def display
    title.blank? ? url : title
  end

  protected

  def url_begins_with_protocol
    errors.add(:url, "must begin with 'http://' or 'https://'") unless url =~ /http(s)?:\/\/.+/
  end

end
