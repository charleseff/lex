class Resource < ActiveRecord::Base
  has_and_belongs_to_many :grade_levels

  def ==(other)
    return false if not other.is_a? Resource
    return true if other.name == name
    return false

  end

end
