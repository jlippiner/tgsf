class UniteDonationsController < ApplicationController
  layout "admin"

  # GET /unite_donations
  # GET /unite_donations.xml
  def index
    redirect_to new_unite_donation_path
  end

  # GET /unite_donations/1
  # GET /unite_donations/1.xml
  def show
    @unite_donation = UniteDonation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @unite_donation }
    end
  end

  def filter
    @unite_donation = UniteDonation.new({:donated_at => Date.today})

    if params[:filter]
      @donations = []
      UniteDonation.find_all_by_donation_type('Check').inject(@donations) {|arr,x| arr << x} if params[:filter][:check]
      UniteDonation.find_all_by_donation_type('Cash').inject(@donations) {|arr,x| arr << x} if params[:filter][:cash]
      UniteDonation.find_all_by_donation_type('Credit').inject(@donations) {|arr,x| arr << x} if params[:filter][:credit]
    else
      @donations = UniteDonation.all(:order => "donated_at DESC")
    end


    render :new
  end

  # GET /unite_donations/new
  # GET /unite_donations/new.xml
  def new
    @unite_donation = UniteDonation.new({:donated_at => Date.today})
    @donations = UniteDonation.all(:order => "donated_at DESC")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @unite_donation }
    end
  end

  # GET /unite_donations/1/edit
  def edit
    @unite_donation = UniteDonation.find(params[:id])
  end

  # POST /unite_donations
  # POST /unite_donations.xml
  def create
    @unite_donation = UniteDonation.new(params[:unite_donation])
    @donations = UniteDonation.all(:order => "donated_at DESC")

    respond_to do |format|
      if @unite_donation.save
        flash[:notice] = 'The donation was successfully created.'
        format.html { redirect_to new_unite_donation_path }
        format.xml  { render :xml => @unite_donation, :status => :created, :location => @unite_donation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @unite_donation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /unite_donations/1
  # PUT /unite_donations/1.xml
  def update
    @unite_donation = UniteDonation.find(params[:id])

    respond_to do |format|
      if @unite_donation.update_attributes(params[:unite_donation])
        flash[:notice] = 'UniteDonation was successfully updated.'
        format.html { redirect_to(@unite_donation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @unite_donation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /unite_donations/1
  # DELETE /unite_donations/1.xml
  def destroy
    @unite_donation = UniteDonation.find(params[:id])
    @unite_donation.destroy

    respond_to do |format|
      format.html { redirect_to(unite_donations_url) }
      format.xml  { head :ok }
    end
  end
end
