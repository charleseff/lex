class AssignmentTopic < ActiveRecord::Base
  has_and_belongs_to_many :grade_levels
  has_many :reports

  def ==(other_topic)
    return false if not other_topic.is_a? AssignmentTopic
    return true if other_topic.name == name
    return false

  end

  def self.find_by_id(id)
    return nil if id == 0
    return AssignmentTopic.find( id.to_i)
  end

end
