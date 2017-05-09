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
    skip
    student_params = {age: 35, job_role: 'laywer', tuition_fee: 9000, maintenance_loan: 3500, exp_level: 'student'}
    student = BackBullion::Student.new(student_params)
    income = BackBullion::Income.new(student, @db_interface)

    interest = BackBullion::Interest.new(income)

    assert_equal interest.value, 0.053
  end
end
