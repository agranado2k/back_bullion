module BackBullion
  class DBInterface
    JOB_ROLES = {
        'laywer' => {
        'student' => 0,
        '1st_yr_trainee' =>  38000,
        '2nd_yr_trainee' =>  40000,
        'NQ' =>  63000,
        '1_yr_pqe' =>  70000,
        '2_yr_pqe' =>  75000,
        '3_yr_pqe' =>  82000,
        '4_yr_pqe' =>  88000,
        '5_yr_pqe' =>  93000,
        '6_yr_pqe' =>  98000,
        '7_yr_pqe' =>  101000,
        '8_yr_pqe' =>  103000,
        'junior_partner' =>  180000,
        'Equity_partner' =>  260000
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

    def exp_level_list
      JOB_ROLES['laywer'].keys
    end
  end
end