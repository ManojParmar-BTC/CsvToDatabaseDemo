Rails.application.routes.draw do
  root 'record_csvs#index'
  post 'record_csvs/save' => 'record_csvs#save'
end
