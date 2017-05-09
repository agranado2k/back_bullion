require 'test_helper'

class BackBullionTest < Minitest::Test

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

    income = BackBullion::Income.new(student)

    assert_equal income.value, 38000
  end

  def test_income_for_4_yr_pqe
    student_params = {age: 35, job_role: 'laywer', tuition_fee: 9000, maintenance_loan: 3500, exp_level: '4 yr pqe'}
    student = BackBullion::Student.new(student_params)

    income = BackBullion::Income.new(student)

    assert_equal income.value, 88000
  end

  def test_repayment

  end
end
