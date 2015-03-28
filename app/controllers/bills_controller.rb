class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])
  end

  def update
    @bill = Bill.find(params[:id])
    success = @bill.add_credit(bill_params[:initial_balance])

    redirect_to bill_path(@bill), notice: (success ? "Success" : "Error")
  end

  def bill_custom_create
    # width = 2000;
    # height = 1000; 
    # title_weight = 9000;
    # subtitle_weight = 500;
    # resize_factor = 3;

    # qr_code = "qr.png";
    # #===============================================================
    # #Create a promotion card
    # #===============================================================

    # canvas = Magick::Image.new(width, height){self.background_color = '#45A0D6'}
    # gc = Magick::Draw.new

    # #Title  
    # gc.pointsize(height / 7)
    # gc.font_weight(title_weight);
    # gc.text(0, height / 10 * 6, "Amy Xiao".center(14))
    # gc.draw(canvas)

    # #Subtitle
    # gc.pointsize(height / 12)
    # gc.font_weight(subtitle_weight);
    # gc.text(120, height / 10 * 7.3, "Terminal badass".center(14))
    # gc.draw(canvas)

    # #Company
    # gc.pointsize(height / 14)
    # gc.font_weight(subtitle_weight);
    # gc.text(120, height / 10 * 8.4, "Sartorial Centrifuge".center(14))
    # gc.draw(canvas)

    # #Overlay the image
    # overlay = Magick::Image.read(qr_code).first 
    # overlay.resize!(resize_factor)
    # canvas.composite!(overlay, width - 200 * resize_factor, 25, Magick::OverCompositeOp)

    # canvas.write('tst.png')
    #///////////////////////////////////////////////////////////////

    response = Unirest.post "https://twinword-sentiment-analysis.p.mashape.com/analyze/",
      headers:{
        "X-Mashape-Key" => "vQDeHGbWbpmshcHJMWfHdyqatX3tp1KbOfujsnToX6MONnfR0l",
        "Content-Type" => "application/x-www-form-urlencoded",
        "Accept" => "application/json"
      },
      parameters:{
        "text" => "Food! Glorious food!"
      }

    this = response["type"]
    puts ""

    binding.pry
    redirect_to root_path
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

