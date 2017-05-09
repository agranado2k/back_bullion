module BackBullion
  class Student
    attr_accessor :age, :job_role, :tuition_fee, :maintenance_loan, :exp_level

    def initialize(args)
      @age = args[:age]
      @job_role = args[:job_role]
      @tuition_fee = args[:tuition_fee]
      @maintenance_loan = args[:maintenance_loan]
      @exp_level = args[:exp_level]
    end
  end

  class DBInterface
    JOB_ROLES = {
        'laywer' => {
        'student' => 0,
        '1st yr trainee' =>  38000,
        '2nd yr trainee' =>  40000,
        'NQ' =>  63000,
        '1 yr pqe' =>  70000,
        '2 yr pqe' =>  75000,
        '3 yr pqe' =>  82000,
        '4 yr pqe' =>  88000,
        '5 yr pqe' =>  93000,
        '6 yr pqe' =>  98000,
        '7 yr pqe' =>  101000,
        '8 yr pqe' =>  103000,
        'junior partner' =>  180000,
        'Equity partner' =>  260000
      }
    }

    PLANS = {
      'plan_2' => [{low: 0, high: 21000, value: 0},
                   {low: 21000, high: 25000, value: 30},
                   {low: 35000, high: 30000, value: 67},
                   {low: 30000, high: 50000, value: 217},
                   {low: 50000, high: 500000, value: 217}]
    }

    def salary_for(job_role, exp_level)
      job_role = JOB_ROLES[job_role]
      job_role.nil? ? nil : job_role[exp_level]
    end

    def repayment_by_income_and_plan(income, plan)
      PLANS[plan].select{|i_to_r| income.between?(i_to_r[:low], i_to_r[:high])}.first
    end
  end

  class Income
    def initialize(student, db_interface)
      @student = student
      @db_interface = db_interface
    end

    def value
      salary_for(@student.job_role, @student.exp_level)
    end

    def salary_for(job_role, exp_level)
      @db_interface.salary_for(job_role, exp_level)
    end
  end

  class Repayment
    def initialize(income, db_interface)
      @income = income
      @db_interface = db_interface
    end

    def value
      repayment = repayment_for(@income.value)
      repayment.nil? ? 0 : repayment[:value]
    end

    def repayment_for(income_value)
      @db_interface.repayment_by_income_and_plan(income_value, 'plan_2')
    end
  end

  class Interest
    def initialize(income)
    end

    def value
      0.053
    end
  end

  class StudentFinancialCalculator
    def initialize(student, interest)
      @student = student
      @interest = interest
    end

    def main_debt
      result = 0
      3.times.each do 
        result = (result + @student.tuition_fee + @student.maintenance_loan)*(1+@interest.value)
      end
      result.to_i
    end

    def loan_fo_30_years

    end
  end
end