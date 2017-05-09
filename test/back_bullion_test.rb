require 'test_helper'

class BackBullionTest < Minitest::Test
  def setup
    @db_interface = BackBullion::DBInterface.new
  end

  def test_student
    student_params = {age: 35, job_role: 'laywer', tuition_fee: 9000, maintenance_loan: 3500, exp_level: '1st yr trainee'}
    
    student = BackBullion::Student.new(student_params)

    assert_equal student.age, 35
    assert_equal student.job_role, 'laywer'
    assert_equal student.tuition_fee, 9000
    assert_equal student.maintenance_loan, 3500
    assert_equal student.exp_level, '1st yr trainee'
  end

  def test_income_for_1st_yr_trainee
    student_params = {age: 35, job_role: 'laywer', tuition_fee: 9000, maintenance_loan: 3500, exp_level: '1st yr trainee'}
    student = BackBullion::Student.new(student_params)

    income = BackBullion::Income.new(student, @db_interface)

    assert_equal income.value, 38000
  end

  def test_income_for_4_yr_pqe
    student_params = {age: 35, job_role: 'laywer', tuition_fee: 9000, maintenance_loan: 3500, exp_level: '4 yr pqe'}
    student = BackBullion::Student.new(student_params)

    income = BackBullion::Income.new(student, @db_interface)

    assert_equal income.value, 88000
  end

  def test_repayment_for_until_0_income
    student_params = {age: 35, job_role: 'laywer', tuition_fee: 9000, maintenance_loan: 3500, exp_level: 'student'}
    student = BackBullion::Student.new(student_params)
    income = BackBullion::Income.new(student, @db_interface)

    repayment = BackBullion::Repayment.new(income, @db_interface)

    assert_equal repayment.value, 0
  end

  def test_repayment_for_until_88000_income
    student_params = {age: 35, job_role: 'laywer', tuition_fee: 9000, maintenance_loan: 3500, exp_level: '4 yr pqe'}
    student = BackBullion::Student.new(student_params)
    income = BackBullion::Income.new(student, @db_interface)

    repayment = BackBullion::Repayment.new(income, @db_interface)

    assert_equal repayment.value, 217
  end

  def test_interest_for_student
    student_params = {age: 35, job_role: 'laywer', tuition_fee: 9000, maintenance_loan: 3500, exp_level: 'student'}
    student = BackBullion::Student.new(student_params)
    income = BackBullion::Income.new(student, @db_interface)

    interest = BackBullion::Interest.new(income)

    assert_equal interest.value, 0.053, 0.001
  end

  def test_interest_for_student
    student_params = {age: 35, job_role: 'laywer', tuition_fee: 9000, maintenance_loan: 3500, exp_level: '4 yr pqe'}
    student = BackBullion::Student.new(student_params)
    income = BackBullion::Income.new(student, @db_interface)

    interest = BackBullion::Interest.new(income)

    assert_equal interest.value, 0.053, 0.001
  end

  def test_calculate_main_deb_1
    student_params = {age: 35, job_role: 'laywer', tuition_fee: 9000, maintenance_loan: 3000, exp_level: 'student'}
    student = BackBullion::Student.new(student_params)
    income = BackBullion::Income.new(student, @db_interface)
    interest = BackBullion::Interest.new(income)

    calculator = BackBullion::StudentFinancialCalculator.new(student, interest, nil)

    assert_equal calculator.main_debt, 39952
  end

  def test_calculate_main_deb_2
    student_params = {age: 35, job_role: 'laywer', tuition_fee: 9500, maintenance_loan: 3500, exp_level: '4 yr pqe'}
    student = BackBullion::Student.new(student_params)
    income = BackBullion::Income.new(student, @db_interface)
    interest = BackBullion::Interest.new(income)

    calculator = BackBullion::StudentFinancialCalculator.new(student, interest, nil)

    assert_equal calculator.main_debt, 43282
  end

  def test_calculate_loan_progression_for_30_years
    student_params = {age: 35, job_role: 'laywer', tuition_fee: 9500, maintenance_loan: 3500, exp_level: '4 yr pqe'}
    student = BackBullion::Student.new(student_params)
    income = BackBullion::Income.new(student, @db_interface)
    interest = BackBullion::Interest.new(income)
    repayment = BackBullion::Repayment.new(income, @db_interface)

    calculator = BackBullion::StudentFinancialCalculator.new(student, interest, repayment)

    assert_equal calculator.loan_fo_30_years, [43282, 42833, 42361, 41864, 41340, 40789, 40208, 39597, 38953, 38275, 37561, 36809, 36017, 35183, 34305, 33381, 32408, 31383, 30304, 29168, 27971, 26711, 25384, 23987, 22516, 20967, 19336, 17618, 15809, 13904]
  end
end
