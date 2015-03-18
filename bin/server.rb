require 'webrick'

require_relative '../lib/params'
require_relative '../lib/router'
require_relative '../lib/session'
require_relative '../lib/arl/db_connection'
require_relative './controllers'
require_relative './models'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

require_relative 'routes.rb'

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  $router.run(req, res)
end

trap('INT') { server.shutdown }

server.start
