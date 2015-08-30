class WelcomeController < ApplicationController
  def index
  	@video = Video.last
  end
end
