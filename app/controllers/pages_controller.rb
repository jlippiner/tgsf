class PagesController < ApplicationController
  def index
    @index_active = true
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
  end

  def press
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


  def sub_layout
    if @our_story_active 
      "our_story"
    elsif @what_we_do_active
      "what_we_do"
    elsif @index_active
      "public"
    else
      "pages"
    end
  end

end
