class HomeController < ApplicationController
  def index
    @letter = Letter.new
  end
end
