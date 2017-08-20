Rails.application.routes.draw do
  root to: 'spreadsheets#getdata'
  get '/auth/:provider/callback' => 'sessions#create'
  get 'spreadsheet/getdata' => 'spreadsheets#getdata'
end
