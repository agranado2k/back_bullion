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
end