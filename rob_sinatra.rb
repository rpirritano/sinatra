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

puts rob.routes
