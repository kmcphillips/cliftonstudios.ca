class SystemVariable < ActiveRecord::Base

	validates :key, :presence => true, :uniqueness => true

	def self.get(key)
    find_by_key(key).try(:value)
  end

  def self.readonly?
    get("readonly") == "true" || get("readonly") == "1"
  end
end
