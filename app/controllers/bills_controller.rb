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
    width = 2000;
    height = 1000; 
    title_weight = 9000;
    subtitle_weight = 500;
    resize_factor = 3;

    qr_code = "qr.png";

    response = Unirest.post "https://twinword-sentiment-analysis.p.mashape.com/analyze/",
      headers:{
        "X-Mashape-Key" => "vQDeHGbWbpmshcHJMWfHdyqatX3tp1KbOfujsnToX6MONnfR0l",
        "Content-Type" => "application/x-www-form-urlencoded",
        "Accept" => "application/json"
      },
      parameters:{
        "text" => "This experience is horrible for all interns! You will hate it here"
      }

    @moodrating = response.body["score"]


    #===============================================================
    #Create a promotion card
    #===============================================================

    #Background should go from green (very positive) (02E815) to red (more serious) E80202
    # iRed = 0xE80202.to_i
    # iGreen = 0x02E815.to_i
    # iMidpoint = (iRed - iGreen) / 2 + iGreen
    # iMidValue = (iRed - iGreen) / 2
    # iPosition = (iMidValue * @moodrating + iMidpoint).to_i
    # background = iPosition.to_s(16)
    iRed = 360
    iBlue = 240
    iGreen = 120

    iMidValue = (iRed - iGreen)/2.to_i
    iMidpoint = iMidValue + iGreen

    iPosition = (iMidValue * -1 * @moodrating + iMidpoint).to_i
    background_obj = Paleta::Color.new(:hsl, iPosition, 100, 35)
    background = background_obj.hex.to_s

    canvas = Magick::Image.new(width, height){self.background_color = '#' + background}
    gc = Magick::Draw.new

    #Overlay translucent image
    overlay_image = Magick::Image.read("app/assets/images/engi.png").first
    overlay_image.alpha(Magick::ActivateAlphaChannel)
    # oimg_fac = 3
    overlay_image.resize!(5)
    canvas.composite!(overlay_image, 0, 0, Magick::OverCompositeOp)

    #Overlay the QR Code
    #TODO: Randomize a number from 1 to 8 to use for the bitcoin wallet stuff
    overlay = Magick::Image.read("app/assets/images/b1_pri.jpg").first 
    overlay.resize!(resize_factor)
    canvas.composite!(overlay, 120, 50, Magick::OverCompositeOp)

     #Title  
    gc.pointsize(height / 7)
    gc.font_weight(title_weight);
    gc.text(120, height / 10 * 6.9, "Damien Siegfried")
    gc.draw(canvas)

    #Subtitle
    gc.pointsize(height / 12)
    gc.font_weight(subtitle_weight);
    gc.text(120, height / 10 * 8, "VP Advocate")
    gc.draw(canvas)

    #Company
    gc.pointsize(height / 14)
    gc.font_weight(subtitle_weight);
    gc.text(120, height / 10 * 9, "Sartorial Centrifuge")
    gc.draw(canvas)



    canvas.write('app/assets/images/customBill.png')

    # send_data(canvas.to_blob, :disposition => 'inline', 
    #                          :type => 'image/png')
    #///////////////////////////////////////////////////////////////
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

