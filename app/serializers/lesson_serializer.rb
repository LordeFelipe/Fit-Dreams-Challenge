class LessonSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_time, :duration
  has_one :category

  def start_time 
    self.object.start_time.to_s(:time)
  end

  def duration
    self.object.duration.to_s(:time)
  end
end
