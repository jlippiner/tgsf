class PagesController < ApplicationController
  def our_story
    @our_story_active = true
  end

  def donation
  end

  def aboutsma
    @our_story_active = true
  end

end
