require 'active_support'
require 'active_support/core_ext'
require 'erb'

require_relative './session'
require_relative './params'
require_relative './router'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req, @res = req, res
    @already_built_response = false
    @params = Params.new(req, route_params)
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise 'Attempted to double render' if already_built_response?

    @already_built_response = true
    @res.status = 302
    @res['location'] = url
    session.store_session(@res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise 'Attempted to double render' if already_built_response?

    @already_built_response = true
    @res.body = content
    @res.content_type = content_type
    session.store_session(@res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    controller_name = self.class.to_s.underscore
    filename = "views/#{controller_name}/#{template_name}.html.erb"
    template = File.read(filename)
    render_content(ERB.new(template).result(binding), 'text/html')
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    send(name)
    render(name) if !already_built_response?
  end
end
