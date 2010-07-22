class PagesController < ApplicationController
  def index
    @public_layout = true
  end

  def our_story
    @our_story_active = true
  end

  def what_we_do
    @what_we_do_active = true
  end

  def donation
    @donation_active = true
  end

  def get_involved
    @get_involved_active = true
    @index_active = true

    @featured_involvement = Involvement.find_by_is_featured(true)
    @active_involvements = Involvement.find_all_by_is_active_and_is_featured(true,false)
    @inactive_involvements = Involvement.find_all_by_is_active(false)

    @meta_description = "Help end the #1 genetic killer of infants."
    @meta_description += @featured_involvement.title if @featured_involvement
    @meta_keywords = "SMA, sponsor, disease, infants"
  end

  def get_involved_show
    @involvement = Involvement.find_by_id(params[:id])
    @involvement ||= Involvement.find_by_short_name(params[:id])
    
    @get_involved_active = true
    
    unless @involvement.campaign.blank?
      @donations = Donation.for_campaign(@involvement.campaign)
      @raised = Donation.for_campaign(@involvement.campaign).sum(:amount)
    end
    
    if @involvement.partial_file_name.blank?
      render :template => 'pages/get_involved/show'
    else
      render :template => "pages/get_involved/#{@involvement.partial_file_name}"
    end
  end

  def alternate(a,b)
    larger,smaller = (a.length >= b.length) ? [a,b] : [b,a]
    new_array = []
    (0...larger.size).each {|ndx|
      new_array << larger[ndx]
      new_array << smaller[ndx] if smaller[ndx]
    }
    new_array
  end


  def press
    @presses = Press.all(:order => "created_at desc")
    @press_active = true
  end

  def about_gwendolyn
    @our_story_active = true
  end

  def about_sma
    @our_story_active = true
  end

  def newly_diagnosed
    @our_story_active = true
  end

  def gallery
    @our_story_active = true
  end

  def awareness
    @what_we_do_active = true
  end

  def support
    @what_we_do_active = true
  end

  def research
    @what_we_do_active = true
  end

  def chase

  end

  def sub_layout
    if @our_story_active
      "our_story"
    elsif @what_we_do_active
      "what_we_do"
    elsif @public_layout
      "public"
    else
      "pages"
    end
  end

end
