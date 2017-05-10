module BackBullion
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
end