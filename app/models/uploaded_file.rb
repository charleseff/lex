class UploadedFile

  has_attachment     :storage => :file_system,
          :max_size => 500.kilobytes
ss
  validates_as_attachment


  #  def uploaded_file=(field)
  #    f = 3
  ##    self.name         = base_part_of(picture_field.original_filename)
  ##    self.content_type = picture_field.content_type.chomp
  ##    self.data         = picture_field.read
  #  end

end