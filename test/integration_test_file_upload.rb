module ActionController
  module Integration
    class Session
      def multipart_post(url, parameters, headers = {})
        boundary = "----------XnJLe9ZIbbGUYtzPQJ16u1"
        post url, multipart_body(parameters, boundary), headers.merge({"CONTENT_TYPE" => "multipart/form-data; boundary=#{boundary}"})
      end
      
      def multipart_requestify(params)
        returning p = {} do
          params.each do |key, value|
            if Hash === value
              value.each do |subkey, subvalue|
                p["#{CGI.escape(key.to_s)}[#{CGI.escape(subkey.to_s)}]"] = subvalue
              end
            else
              p[CGI.escape(key.to_s)] = value
            end
          end
        end
      end

      def multipart_body(params, boundary)
        multipart_requestify(params).map do |key, value|
          if value.respond_to?(:original_filename)
            File.open(value.path) do |f|
              <<-EOF
--#{boundary}\r
Content-Disposition: form-data; name="#{key}"; filename="#{CGI.escape(value.original_filename)}"\r
Content-Type: #{value.content_type}\r
Content-Length: #{File.stat(value.path).size}\r
\r
#{f.read}\r
EOF
            end
          else
            <<-EOF
--#{boundary}\r
Content-Disposition: form-data; name="#{key}"\r
\r
#{value}\r
EOF
          end
        end.join("")+"--#{boundary}--\r"
      end
    end
  end
end

