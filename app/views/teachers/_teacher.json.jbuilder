json.extract! teacher, :id, :name, :online_teacher_id, :service_name, :user_id, :deleted, :created_at, :updated_at
json.url teacher_url(teacher, format: :json)