class ExamWindowSerializer < ActiveModel::Serializer
  attributes :id, :exam_id, :start, :end
end
