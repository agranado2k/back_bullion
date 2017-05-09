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
  
  puts "student_params: #{student_params}"
  puts "params: #{params}"

  db_interface = BackBullion::DBInterface.new
  student = BackBullion::Student.new(student_params)
  income = BackBullion::Income.new(student, db_interface)
  interest = BackBullion::Interest.new(income)
  repayment = BackBullion::Repayment.new(income, db_interface)

  calculator = BackBullion::StudentFinancialCalculator.new(student, interest, repayment)

  content_type :json
  calculator.loan_fo_30_years.to_json
end