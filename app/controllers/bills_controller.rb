class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])
  end

  def update
    @bill = Bill.find(params[:id])
    @bill.update_attributes(initial_balance: bill_params[:initial_balance])
    redirect_to bill_path(@bill), notice: "Success"
  end

  def unused_bill
    @bill = Bill.find_by(initial_balance: nil)
    if @bill
      redirect_to bill_path(@bill)
    else
      redirect_to root_path, notice: "Error"
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:initial_balance)
  end
end

