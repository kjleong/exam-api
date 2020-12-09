class ExamSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :college_id, :name
end
