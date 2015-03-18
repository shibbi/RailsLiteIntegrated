require_relative '../lib/router'

$router = Router.new
$router.draw do
  get Regexp.new("^/$"), MyController, :show
  # get Regexp.new("^/humans$"), HumanController, :index
  # get Regexp.new("^/humans/new$"), HumanController, :new
  # post Regexp.new("^/humans$"), HumanController, :create
  # get Regexp.new("^/humans/(?<human_id>\\d+)$"), HumanController, :show
  get Regexp.new("^/cats$"), CatsController, :index
  get Regexp.new("^/cats/new$"), CatsController, :new
  post Regexp.new("^/cats$"), CatsController, :create
  get Regexp.new("^/cats/(?<id>\\d+)$"), CatsController, :show
end
