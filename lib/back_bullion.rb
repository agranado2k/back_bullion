require_relative './back_bullion/student'
require_relative './back_bullion/db_interface'
require_relative './back_bullion/income'
require_relative './back_bullion/repayment'
require_relative './back_bullion/interest'
require_relative './back_bullion/student_financial_calculator'

module BackBullion
  def self.calculate_student_financial_loan_progression(student_params)
    db_interface = BackBullion::DBInterface.new
    student = BackBullion::Student.new(student_params)
    income = BackBullion::Income.new(student, db_interface)
    interest = BackBullion::Interest.new(income)
    repayment = BackBullion::Repayment.new(income, db_interface)
    calculator = BackBullion::StudentFinancialCalculator.new(student, interest, repayment)
    calculator.loan_fo_30_years
  end
end