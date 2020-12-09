Rails.application.routes.draw do
  resources :exam_windows
  resources :exams
  resources :colleges
  resources :users

  post '/user_exam/new', to: 'user_exam#create'
end
