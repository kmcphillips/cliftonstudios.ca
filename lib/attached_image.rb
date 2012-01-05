module AttachedImage

  def self.included(base)
    base.extend ClassMethods
    base.instance_eval do

      has_attached_file :image,
        :styles => IMAGE_SIZES,
        :default_style => :full,
        :whiny => true,
        :path => ":rails_root/public/assets/images/:class/:id_:style.:extension",
        :url => "/assets/images/:class/:id_:style.:extension"

      attr_accessor :delete_image

      before_validation :maybe_delete_image

      validates_attachment_size :image, :in => 1..2.megabytes
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

  def delete_image?
    delete_image && !delete_image.to_i.zero?
  end

  def maybe_delete_image
    self.image = nil if delete_image?
  end

end
