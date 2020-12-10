Rails.application.routes.draw do
  resources :exam_windows
  resources :exams
  resources :colleges
  resources :users

  post '/user_exams/new', to: 'user_exams#create'
end
