class JodConverter

  # to convert odt files to doc, and doc files to pdf
  def self.convert(input,output)
     `java -jar #{RAILS_ROOT}/lib/java/jodconverter/jodconverter-cli-2.2.1.jar #{input} #{output}`
     
=begin
    # web service call canceled in favor of local call:
    system "
    wget #{APP_CONFIG['jodconverter_url']} --post-file=#{doc_path.convert_to_bash_filepath} \
      --header=\"Content-Type: application/msword\"  --header=\"Accept: application/pdf\" \
      --output-document=#{pdf_path.convert_to_bash_filepath} 2> /dev/null"
=end
  end
end
