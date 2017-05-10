module BackBullion
  class StudentFinancialCalculator
    def initialize(student, interest, repayment)
      @student = student
      @interest = interest
      @repayment = repayment
    end

    def main_debt
      result = 0
      3.times.each do 
        result = (result + @student.tuition_fee + @student.maintenance_loan)*(1+@interest.value)
      end
      result.to_i
    end

    def loan_fo_30_years
      result = []
      result.push(main_debt)
      annually_repayment = @repayment.value*12
      29.times.each_with_index do |index|
        current_debt = result[index]
        result[index+1] = ((current_debt - annually_repayment)*(1+@interest.value)).to_i
        result[index+1] = 0 if result[index+1] < 0
      end
      result
    end
  end
end