# Rails Lite Integrated!

## Description

Compiled from [ActiveRecordLite][arl] and [RailsLite][rl] with phases and
specs into an integrated mock Rails server.

## Setup

1. Define models in bin/models.rb
2. Define controllers in bin/controllers.rb
3. Define views under views/controller_name (i.e. for a Cats controller
  the files would be under views/cats_controller)
4. Define routes under bin/routes.rb (must specify HTTP method, pattern,
  controller class, and action)

## How to use

1. Run `ruby bin/server.rb`
2. Navigate to `localhost:3000` in browser
3. Enjoy browsing the current cats and creating new ones :)

[arl]: https://github.com/shibbi/ruby/tree/master/ActiveRecordLite
[rl]: https://github.com/shibbi/ruby/tree/master/RailsLite
