class UftcController < ApplicationController
  layout "picture_frame"

  def index
    @donations = UniteDonation.sum(:amount, :group => :unite, :order => "sum(amount) desc")
    @total = UniteDonation.sum(:amount)
  end

  def show
    @uftc_access = cookies[:uftc_access]
    if params[:access_code] == 'cure'
      @uftc_access ||= true
      cookies[:uftc_access] = { :value => true, :expires => 1.year.from_now }
      flash.notice = "Authorization code accepted."
    elsif !params[:access_code].blank?
      flash.error = "Sorry.  That code is unauthorized."
    end

    @uniter = Unite.find_by_id(params[:id])
    @donations = @uniter.unite_donations(:order => "donated_at DESC")
    @total_raised = @uniter.unite_donations.sum(:amount)
  end

end
