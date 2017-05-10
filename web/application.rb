require 'sinatra'
require 'json'
require_relative '../lib/back_bullion'

set :public_folder, File.dirname(__FILE__) + '/web/assets'

def exp_level_list
  BackBullion::DBInterface.new.exp_level_list
end

get '/' do
  erb :index
end

post '/calculate' do
  student_params = {age: params['age'], job_role: params['job_role'], tuition_fee: params['tuition_fee'].to_i, 
                    maintenance_loan: params['maintenance_loan'].to_i, exp_level: params['exp_level']}
  content_type :json
  BackBullion.calculate_student_financial_loan_progression(student_params).to_json
end