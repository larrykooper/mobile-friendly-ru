Rails.application.routes.draw do
  devise_for :users
  root to: 'spreadsheets#getdata'
  get '/auth/:provider/callback' => 'sessions#create'
  get 'spreadsheet/getdata' => 'spreadsheets#getdata'
  get '/search' => 'ru_items#search'
end
