module BackBullion
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
end