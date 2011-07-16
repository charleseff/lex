class Report < ActiveRecord::Base
  belongs_to :student
  belongs_to :grader
  belongs_to :book
  belongs_to :grade_level
  belongs_to :assignment_topic
  has_many :dialog_messages
  has_many :grading_failures
  has_many :graded_ptal_task_items

  validates_presence_of :book
  validates_presence_of :student_id
  validates_presence_of :assignment_topic
  validates_associated :book
  validates_associated :grade_level
  validates_presence_of :assigned_to_grader_at, :if => :has_grader?

  validate_on_create :submitted_doc_is_correct
  validate_on_update :grader_doc_is_correct

  attr_accessor :submitted_doc, :grader_doc, :save_for_submission

  REPLACEMENT_CHARACTERS = /[\,?;= +<>|"\[\]\/':\*\(\)]/

  def after_initialize
    @subtotals = {}
  end

  def to_label
    "report on '#{book.title}'" << (student.nil? ? ', orphaned' :
        " by #{student.first_name} #{student.last_name.slice(0,1)}.")
  end

  def has_grader?
    grader
  end

  ##
  # Gets a list of all unassigned reports.  In the future this ought to be cached (for now, not)
  def self.unassigned_reports
    find_all_by_grader_id(nil, :order => 'created_at ASC' )
  end

  def to_s
    "Report \##{id}"
  end

  def grader_messages
    @grader_messages ||= dialog_messages.select { |message| message.speaker =='Grader'}
  end

  def student_messages
    @student_messages ||= dialog_messages.select { |message| message.speaker =='Student'}
  end

  def graded_ptal_task_items_hashed_by_task_item
    @graded_ptal_task_items_hashed_by_task_item ||= lambda {
      graded_ptal_task_items_hashed_by_task_item = {}
      graded_ptal_task_items.each do |graded_ptal_task_item|
        graded_ptal_task_items_hashed_by_task_item[graded_ptal_task_item.ptal_task_item] = graded_ptal_task_item
      end
      return graded_ptal_task_items_hashed_by_task_item
    }.call
  end

  def graded_ptal_task_items_data_is_valid
    grade_level.ptal_task_items.each do |ptal_task_item|
      if graded_ptal_task_items_hashed_by_task_item[ptal_task_item] == nil or
          graded_ptal_task_items_hashed_by_task_item[ptal_task_item].points_earned == nil or
          graded_ptal_task_items_hashed_by_task_item[ptal_task_item].points_earned == ''
        return false
      end
    end
    return true
  end

  def active?
    (not graded?) or
        ( graded? and ( Time.now < time_active_until ) )
  end

  def final_grade_indefinite_article
    @final_grade_indefinite_article ||= Report.calculate_indefinite_article(final_grade)
  end

  def final_grade
    if submitted_for_preview?
      @final_grade ||= Report.calculate_letter_grade_from_percentage(percentage_grade)
      return @final_grade
    else
      return 'n/a'
    end
  end

  def self.calculate_letter_grade_from_percentage(percentage)
    return percentage >= 0.97 ? 'A+' :
        percentage >= 0.94 ? 'A' :
            percentage >= 0.9 ? 'A-' :
                percentage >= 0.87 ? 'B+' :
                    percentage >= 0.84 ? 'B' :
                        percentage >= 0.8 ? 'B-' :
                            percentage >= 0.77 ? 'C+' :
                                percentage >= 0.74 ? 'C' :
                                    percentage >= 0.7 ? 'C-' :
                                        percentage >= 0.64 ? 'D' :
                                            'F'
  end

  def percentage_grade
    total_points_earned.to_f / grade_level.total_possible_points.to_f
  end

  def total_points_earned
    @total_points_earned ||= lambda {
      total_points_earned = 0
      graded_ptal_task_items.each do |graded_ptal_task_item|
        total_points_earned += graded_ptal_task_item.points_earned.to_i
      end
      return total_points_earned
    }.call
  end

  def time_active_until
    graded_at + MAX_IDLE_ACTIVE_TIME
  end


  def hours_left_before_grading_due
     days_left_before_grading_due * 24
   end

  def days_left_before_grading_due
     (grading_due - DateTime.now).to_f
   end

  def grading_due
    exactly_three_days_later =
          grader.tz.utc_to_local(assigned_to_grader_at + MAX_TIME_TO_GRADE_REPORTS)
    twentythree_fiftynine_in_graders_timezone_of_three_days_later =
         DateTime.parse(exactly_three_days_later.strftime('%d-%m-%Y 23:59:00 PM'))
    return grader.tz.local_to_utc(twentythree_fiftynine_in_graders_timezone_of_three_days_later)
  end


  def subtotal(category)
    return @subtotals[category] if not @subtotals[category].nil?

    subtotal = 0
    category_data = grade_level.ptal_categories[category]
    category_data[:task_items].each do |task_item|
      graded_ptal_task_item = graded_ptal_task_items_hashed_by_task_item[task_item]
      subtotal += graded_ptal_task_item.points_earned.to_i if not graded_ptal_task_item.nil?
    end

    @subtotals[category] = subtotal
    return @subtotals[category]
  end

  def graded?
    graded_at != nil
  end

  def before_create
    self.grade_level = student.grade_level
  end

  def self.calculate_indefinite_article(grade)
    case grade
    when 'A+','A','A-','F'
      'an'
    else
      'a'
    end
  end

  def numerical_grade
    if submitted_for_preview?
      "#{total_points_earned}/#{grade_level.total_possible_points}"
    else
      'n/a'
    end
  end

  # gets all sample reports
  # todo: this should be cahced (memcached?)
  def self.sample_reports
    @sample_reports ||= Student.find_all_by_sample(true).map{|student| student.reports}.flatten
  end

  # returns true if report is valid for submitting by grader:
  def valid_for_submission?
    @errors_for_submission ||= create_errors_for_submission
    return (@errors_for_submission.empty? and valid?)
  end

  def errors_for_submission
    @errors_for_submission ||= create_errors_for_submission
    return errors.full_messages + @errors_for_submission
  end

  def after_create
    FileUtils.mkdir_p(path_to_docs)
    position_doc(submitted_doc,@submitted_doc_type, path_to_submitted_doc)
  end

  # add grader_doc if can:
  def before_update
    FileUtils.mkdir_p(path_to_docs)
    if grader_doc and not grader_doc.is_a? String
      self.grader_doc_updated_at = Time.now
      position_doc(grader_doc,@grader_doc_type, path_to_grader_doc)
    end

    if save_for_submission
      self.has_pdf = true
      convert_to_pdf_and_swf
    end
  end

  def path_to_submitted_doc
    path_to_docs + '/' + submitted_doc_filename
  end

  def path_to_grader_doc
    path_to_docs + '/' + grader_doc_filename
  end

  def path_to_graded_pdf
    path_to_docs + '/' + graded_pdf_filename
  end

  def path_to_graded_swf
    path_to_docs + '/' + graded_swf_filename
  end

  def grader_doc_filename
    "#{student.first_name}#{student.last_name.slice(0,1)}_#{book.title.gsub(' ','')}_graded.doc".gsub(REPLACEMENT_CHARACTERS,'_')
  end

  def graded_pdf_filename
    "#{student.first_name}#{student.last_name.slice(0,1)}_#{book.title.gsub(' ','')}_graded.pdf".gsub(REPLACEMENT_CHARACTERS,'_')
  end

  def graded_swf_filename
    "#{student.first_name}#{student.last_name.slice(0,1)}_#{book.title.gsub(' ','')}_graded.swf".gsub(REPLACEMENT_CHARACTERS,'_')
  end

  def submitted_doc_filename
    "#{student.first_name}#{student.last_name.slice(0,1)}_#{book.title.gsub(' ','')}.doc".gsub(REPLACEMENT_CHARACTERS,'_')
  end

  def has_grader_doc?
    grader_doc_updated_at != nil
  end

  private
  # this method only works after the report has been saved (i.e. after an id has been generated)
  def path_to_docs
    @path_to_docs ||= File.join(APP_CONFIG['data_dir'], *("%012d" % id).scan(/..../))
  end


  def create_errors_for_submission
    errors = []
    errors << "You must choose a value for every task item in the PTAL"  unless graded_ptal_task_items_data_is_valid
    errors << "You must make a final comment." if grader_comment.nil? or grader_comment == ''
    errors << 'You must include a graded report'     unless has_grader_doc? or (grader_doc and not grader_doc.is_a? File)
    return errors
  end

  def submitted_doc_is_correct
    @submitted_doc_type = get_type_or_nil(submitted_doc)
    errors.add("Submitted document must be in Microsoft Word format") if not @submitted_doc_type
  end

  def grader_doc_is_correct
    return unless grader_doc and not grader_doc.is_a? String
    @grader_doc_type = get_type_or_nil(grader_doc)
    errors.add("Submitted document must be in Microsoft Word format")   if not @grader_doc_type
  end

  def get_type_or_nil(doc)
    return nil if doc.is_a? String
      if doc.content_type == 'application/msword'
        return 'doc'
      elsif ['application/x-zip-compressed', 'application/octet-stream', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'].detect{
          |content_type| content_type == doc.content_type} and
          `file #{doc.path} -b` =~ /Zip archive data/
        # docx file most likely:
        return 'docx'
      else
        return nil
      end
  end

  def position_doc(doc,type,path)
    case type
      when 'doc'
        File.open(path, "wb") { |f| f.write(doc.read) }
      when  'docx'
      File.rename(doc.path,"#{doc.path}.docx")
      # convert to odt:
      OdfConverter.convert("#{doc.path}.docx","#{doc.path}.odt" )
      # then convert to doc:
      JodConverter.convert("#{doc.path}.odt",path)
    else
      raise Exception.new('error')
      end
    end

  def convert_to_pdf_and_swf
    JodConverter.convert(path_to_grader_doc,path_to_graded_pdf)
    PdfToSwfConverter.convert(path_to_graded_pdf,path_to_graded_swf)
  end

end
