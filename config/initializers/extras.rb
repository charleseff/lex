require 'digest/sha2'
require 'digest/sha1'
require 'ftools'

ActiveRecord::Errors.default_error_messages[:invalid] = ""

ExceptionNotifier.exception_recipients = %w(exception_notifiees@barrelny.com)

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  msg = instance.error_message
  title = msg.kind_of?(Array) ? '* ' + msg.join("\n* ") : msg
  "<div class=\"fieldWithErrors\" title=\"#{title}\">#{html_tag}</div>"
end

module ActiveRecord
  class Errors
    alias_method :on_without_id_stripping, :on
    def on(attribute)
      on_without_id_stripping(attribute.to_s.sub(/_id$/, ''))
    end
  end
end

MAX_IDLE_ACTIVE_TIME = 48.hours
MAX_TIME_TO_GRADE_REPORTS = 72.hours
HOURS_BEFORE_SENDING_REPORT_DUE_WARNING = 24
HOURS_BEFORE_SENDING_REPORT_ARCHIVE_NOTICE = 12

# returns doc or docx depending on which type it is:
class ActionController::UploadedTempfile
  def doc_or_docx
    if self.content_type == 'application/msword'
      return 'doc'
    elsif ['application/x-zip-compressed', 'application/octet-stream', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'].detect{ |content_type| content_type == self.content_type} and
        `file #{self.path} -b` =~ /Zip archive data/
      # docx file most likely:
      return 'docx'
    else
      return nil
    end
  end
end

class ActionController::UploadedTempfile
  def doc_or_docx
    if self.content_type == 'application/msword'
      return 'doc'
    elsif ['application/x-zip-compressed', 'application/octet-stream', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'].detect{ |content_type| content_type == self.content_type} and
        `file #{self.path} -b` =~ /Zip archive data/
      # docx file most likely:
      return 'docx'
    else
      return nil
    end
  end
end

class ExceptionNotifier < ActionMailer::Base
  @@email_prefix = (ENV['RAILS_ENV'] == 'staging' ? '[STAGING] ' : '') + "[ERROR] "
end

class String
  def convert_to_bash_filepath
    converted = self
    ['(', ')', '[', ']', '\\', ' '].each do |char|
      converted.gsub!(char, '\\' + char)
    end
    return converted
  end
end

ActiveRecord::Base.default_timezone = :utc # Store all times in the db in UTC
require 'tzinfo' # Use tzinfo library to convert to and from the users timezone
ENV['TZ'] = 'UTC' # This makes Time.now return time in UTC