class ProductsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :destroy, :edit, :update, :show]




  def index
  end

  def new
  end
  
end
