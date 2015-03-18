# Rails Lite Integrated!

## Description

Compiled from Rails Lite with phases and specs into an integrated mock
Rails server.

## How To Use

1. Define models in bin/models.rb
2. Define controllers in bin/controllers.rb
3. Define views under views/controller_name (i.e. for a Cats controller
  the files would be under views/cats_controller)
4. Define routes under bin/routes.rb (must specify HTTP method, pattern,
  controller class, and action)
