require_relative '../lib/router'

$router = Router.new
$router.draw do
  get Regexp.new("^/$"), CatsController, :index
  get Regexp.new("^/cats$"), CatsController, :index
  get Regexp.new("^/cats/new$"), CatsController, :new
  post Regexp.new("^/cats$"), CatsController, :create
  get Regexp.new("^/cats/(?<id>\\d+)$"), CatsController, :show
end
