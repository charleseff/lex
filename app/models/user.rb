class User < ActiveRecord::Base

  EMAIL_VALIDATION_REGEX = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_presence_of     :email, :first_name, :last_name
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email, :case_sensitive => false
  before_save :encrypt_password
  # for polymorphism:
  belongs_to :role, :polymorphic => true

  composed_of :tz, :class_name => 'TZInfo::Timezone',
      :mapping => %w(time_zone time_zone)


=begin

  composed_of :tz,
      :class_name => 'TimeZone' ,
      :mapping => %w(time_zone name)

=end

  validate :email_isnt_yahoo_co_kr

  def validate
    if (not email =~ EMAIL_VALIDATION_REGEX )
      errors.add(:email, "is not valid format")
    end
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(email, password)
    u = find_by_email(email) # need to get the salt
    if     u && u.authenticated?(password) && (not u.sample)
      if u.is_a? Student or u.is_a? Grader
        u.confirmed ? u : nil
      else
        u
      end
    else
      nil
    end
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    self.remember_token_expires_at = 2.weeks.from_now.utc
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  def to_label
    "#{email}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  protected
  # before filter
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
    self.crypted_password = encrypt(password)
  end

  def password_required?
    crypted_password.blank? || !password.blank?
  end

  # first name and last name:
  # todo: if an admin is logged in show full last name; else show last initial
  def name
    "#{first_name} #{last_name}"
  end

  def before_create
    self.time_zone = default_timezone
  end

  def default_timezone
    "London"
  end

  private
  def email_isnt_yahoo_co_kr
    errors.add("Please do not use email accounts from Yahoo.co.kr.  Try an alternative like Gmail.com") if email =~ /yahoo.co.kr\Z/
#    errors.add("Please do not use email accounts from Hanmail.  Try an alternative like Gmail.com") if email =~ /hanmail.com\Z/
  end

end
