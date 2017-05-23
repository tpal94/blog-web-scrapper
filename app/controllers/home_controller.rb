class HomeController < ApplicationController

  before_action :admin_required

  def dashboard
  	@searches = SearchHistory.all

  end



end
