require 'csv'

class RecordCsvsController < ApplicationController
  def index
    @users = User.all
  end

  def save
    counts = 0
    if params[:csv_file].present?
      unless params[:csv_file].content_type == 'text/csv'
        raise StandardError, 'please upload valid csv file.'
      end
      CSV.foreach(params[:csv_file].path, headers: true) do |row|
        if row['Name'].present? && row['Email Address'].present?
          user = User.find_or_create_by(email: row['Email Address'])
          user_data = { name: row['Name'],
                        email: row['Email Address'], telephone: row['Telephone Number'], website: row['Website'] }
          counts += 1 if user.update(user_data)
        end
      end
      flash[:success] = "#{counts} records updated."
      redirect_to root_path
    end
  rescue => exception
    flash[:danger] = "Error: #{exception}"
    redirect_to root_path
  end
end
