class PdfToSwfConverter

  def self.convert(input, output)
    system "pdf2swf -tbl #{input} -o #{output}"
  end

end