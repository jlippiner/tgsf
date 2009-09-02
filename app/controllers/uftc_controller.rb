class UftcController < ApplicationController
  def index
    @donations = UniteDonation.sum(:amount, :group => :unite, :order => "sum(amount) desc")
    @total = UniteDonation.sum(:amount)
  end

  def show
    @uniter = Unite.find_by_id(params[:id])
    @donations = @uniter.unite_donations(:order => "donated_at DESC")
    @total_raised = @uniter.unite_donations.sum(:amount)
  end

end
