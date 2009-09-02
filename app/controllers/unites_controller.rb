class UnitesController < ApplicationController
  layout 'admin'

  # GET /unites
  # GET /unites.xml
  def index
    @unites = Unite.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @unites }
    end
  end

  # GET /unites/1
  # GET /unites/1.xml
  def show
    @unite = Unite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @unite }
    end
  end

  # GET /unites/new
  # GET /unites/new.xml
  def new
    @unite = Unite.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @unite }
    end
  end

  # GET /unites/1/edit
  def edit
    @unite = Unite.find(params[:id])
  end

  # POST /unites
  # POST /unites.xml
  def create
    @unite = Unite.new(params[:unite])

    respond_to do |format|
      if @unite.save
        flash[:notice] = 'Unite was successfully created.'
        format.html { redirect_to(@unite) }
        format.xml  { render :xml => @unite, :status => :created, :location => @unite }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @unite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /unites/1
  # PUT /unites/1.xml
  def update
    @unite = Unite.find(params[:id])

    respond_to do |format|
      if @unite.update_attributes(params[:unite])
        flash[:notice] = 'Unite was successfully updated.'
        format.html { redirect_to(@unite) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @unite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /unites/1
  # DELETE /unites/1.xml
  def destroy
    @unite = Unite.find(params[:id])
    @unite.destroy

    respond_to do |format|
      format.html { redirect_to(unites_url) }
      format.xml  { head :ok }
    end
  end
end
