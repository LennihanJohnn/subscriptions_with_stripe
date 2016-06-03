class ChargesController < ApplicationController
  before_action :authenticate_user!

  def show
    @charge = current_user.charges.find(params[:id])
    respond_to do |format|
      format.pdf do
        send_data @charge.receipt.render,
          filename: "#{@charge.created_at.strftime("%Y-%m-%d")}-gorails-receipt.pdf",
          type: "application/pdf",
          disposition: :inline
      end
    end
  end
end
