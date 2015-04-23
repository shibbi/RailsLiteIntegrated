require 'byebug'
require_relative '../lib/controller_base'
require_relative '../lib/flash'
require_relative './models'

class CatsController < ControllerBase
  def index
    @cats = Cat.all
    render :index
  end

  def new
    @cat = Cat.new
    @humans = Human.all
    render :new
  end

  def create
    begin
      @cat = Cat.new(params[:cat])
    rescue
      puts "Attribute not found; params: #{params}"
    end
    if @cat.save
      redirect_to("/cats")
    else
      render :new
    end
  end

  def show
    @cat = Cat.find(params[:id].to_i)
    if @cat
      render :show
    end
  end
end
