class HomeController < ApplicationController
  def index
    @my_id = ENV['GOOGLE_CLIENT_ID']
  end
end
