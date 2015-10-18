class Photo < ActiveRecord::Base
  belongs_to :place
  mount_uploader :picture, PictureUploader 

   def reprocess
    begin
      self.process_photo_upload = true
      self.picture.cache_stored_file!
      self.picture.retrieve_from_cache!(picture.cache_name)
      self.picture.recreate_versions!
      self.save!
    rescue => e
      STDERR.puts  "ERROR: Photo: #{id} -> #{e.to_s}"
    end
  end
end
