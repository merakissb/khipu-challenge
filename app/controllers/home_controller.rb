# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    @products = Product.all
  end
end
