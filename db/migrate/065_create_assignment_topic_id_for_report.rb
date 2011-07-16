class CreateAssignmentTopicIdForReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :assignment_topic_id, :integer

    # just set assignment topic to 1 for all reports:
    ActiveRecord::Base.connection.update("update reports set assignment_topic_id = 1")


  end

  def self.down
    remove_column :reports, :assignment_topic_id
  end
end
