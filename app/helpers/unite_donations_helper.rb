module UniteDonationsHelper

  def cb_check(what)
    return true if params[:filter].nil?
    
    return true if params[:filter][what]
    
    return false
  end

end
