class SeedAutoincrementOnPictures < ActiveRecord::Migration
  def self.up
    Picture.connection.execute("ALTER TABLE pictures AUTO_INCREMENT = 65536")
  end

  def self.down
  end
end
