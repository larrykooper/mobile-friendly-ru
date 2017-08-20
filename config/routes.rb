Rails.application.routes.draw do
  root to: 'spreadsheets#getdata'
  resources :sessions, only: :index
  get '/auth/:provider/callback' => 'sessions#create'
  get 'spreadsheet/getdata' => 'spreadsheets#getdata'
end
