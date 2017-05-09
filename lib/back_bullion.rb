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

  class Income
    EXP_LEVEL_TO_SALARY = {
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

    def initialize(student)
      @student = student
    end

    def value
      EXP_LEVEL_TO_SALARY[@student.exp_level]
    end
  end
end