module AttachedImage

  def self.included(base)
    base.extend ClassMethods
    base.instance_eval do

      has_attached_file :image,
        :styles => IMAGE_SIZES,
        :default_style => :full,
        :whiny => true,
        :path => ":rails_root/public/assets/images/:class/:id/:style_:basename.:extension",
        :url => "/assets/images/:class/:id/:style_:basename.:extension"

      validates_attachment_size :image, :in => 1..6.megabytes
      validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/pjpeg", "image/png", "image/tiff", "image/x-png", "image/gif"]

      IMAGE_SIZES.each_key do |key|
        define_method key do
          self.image.url(key)
        end
      end

    end
  end

  module ClassMethods
  end

  protected

end
