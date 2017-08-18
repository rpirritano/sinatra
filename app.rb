# app.rb
# run with `ruby app.rb`
require "./rob_sinatra"

get "/" do
  "Hey there!"
end

Rack::Handler::WEBrick.run Robert::Application, Port: 9292
