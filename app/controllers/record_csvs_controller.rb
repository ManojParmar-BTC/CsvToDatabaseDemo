require 'csv'

class RecordCsvsController < ApplicationController
  def index
    @users = User.all
  end

  def save
    counts = 0
    CSV.foreach(params[:csv_file].path, headers: true) do |row|
      if(row['name'].present? && row['email'].present?)
        user = User.find_or_create_by(email: row['email'])
        user_data = {name: row['name'], email: row['email'], age: row['age'], address: row['address']}
        counts += 1 if user.update(user_data)
      end
    end
    flash[:success] = "#{counts} records updated."
    redirect_to root_path
  rescue => exception
    flash[:danger] = "Error: #{exception}"
    redirect_to root_path
  end
end
