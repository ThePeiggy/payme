class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])
  end

  def update
    @bill = Bill.find(params[:id])
    @bill.update_attributes(initial_balance: bill_params[:initial_balance])
    redirect_to bill_path(@bill), notice: "Success"
  end

  private

  def bill_params
    params.require(:bill).permit(:initial_balance)
  end
end
