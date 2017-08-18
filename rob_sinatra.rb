require "rack"



module Rob
  class Base
    def initialize
      @routes = {}
    end

    attr_reader :routes

    def get(path, &handler)
      route("GET", path, &handler)
    end

    #to make a Rack app by adding a minimal call method
    def call(env)
      @request = Rack::Request.new(env)
      verb = @request.request_method
      requested_path = @request.path_info
#handle error of no route
      handler = @routes.fetch(verb, {}).fetch(requested_path, nil)

      if handler
        handler.call
      else
        [404, {}, ["Oops! No rote for #{verb} #{requested_path}"]]
      end
    end

=begin
    First, we grab the verb and requested path (like GET and /the/path)
    from the env parameter using Rack::Request.
    Then we grab the handler block from @routes and call it.
=end

    private
    def route(verb, path, &handler)
      @routes[verb] ||= {}
      @routes[verb][path] = handler
    end
  end
end


rob = Rob::Base.new

rob.get "/hello" do
  [200, {}, ["Robert says hello"]]
end

#add the handler now to run it
Rack::Handler::WEBrick.run rob, Port: 9292
