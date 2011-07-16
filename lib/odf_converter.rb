class OdfConverter

  # to convert docx files to odt
  def self.convert(input,output)
    `OdfConverter /i #{input} /o #{output}`
  end
end
