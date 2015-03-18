require 'byebug'
require_relative '../lib/controller_base'
require_relative '../lib/flash'
require_relative './models'

class CatsController < ControllerBase
  # index, new, create works (haven't tested if save fails)
  def index
    @cats = Cat.all
    render :index
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    begin
      @cat = Cat.new(params[:cat])
    rescue
      puts "Attribute not found; params: #{params}"
    end
    @cat.owner_id = 1
    if @cat.save
      redirect_to("/cats")
    else
      render :new
    end
  end

  def show
    @cat = Cat.find(params[:id].to_i)
    byebug
    if @cat
      render :show
    end
  end
end

class MyController < ControllerBase
  def show
    render :show
  end
end

# class StatusesController < ControllerBase
#   def index
#     statuses = $statuses.select do |s|
#       s[:cat_id] == Integer(params[:cat_id])
#     end
#
#     render_content(statuses.to_s, "text/text")
#   end
# end
#
# class Cats2Controller < ControllerBase
#   def index
#     render_content($cats.to_s, "text/text")
#   end
# end
