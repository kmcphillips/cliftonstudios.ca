class Member < ActiveRecord::Base
  
  acts_as_authentic
  acts_as_permalink :from => :name
  
  include AttachedImage
  
  has_many :posts
  has_many :pictures
  
  validates :name, :presence => {:message => "must be set"}

  def reset_password!
    password = self.class.generate_random_password

    self.password = password
    self.password_confirmation = password

    if save
      password
    end
  end

  protected

  ## At least make an effort to make the password readable
  def self.generate_random_password
    password = ""
    vowels = %w[a e i o u]
    consonants = ("a".."z").to_a - vowels

    (0..4).each do |i|
      password << (i.even? ? consonants : vowels).sample
    end

    password << rand(10).to_s

    password
  end

end
