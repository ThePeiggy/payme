class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])
  end

  def update
    @bill = Bill.find(params[:id])
    update_attributes(title: bill_params[:title])
    success = @bill.add_credit(bill_params[:initial_balance])
    if success
      redirect_to bill_path(@bill), notice: "Success"
    else
      redirect_to bill_custom_create_bills_path, notice: "Error"
    end
  end

  def bill_custom_create

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
    params.require(:bill).permit(:initial_balance, :title)
  end


end

