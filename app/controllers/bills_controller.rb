class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])
  end

  def update
    @bill = Bill.find(params[:id])
    success = @bill.add_credit(bill_params[:initial_balance])

    redirect_to bill_path(@bill), notice: (success ? "Success" : "Error")
  end

  private

  def bill_params
    params.require(:bill).permit(:initial_balance)
  end
end
