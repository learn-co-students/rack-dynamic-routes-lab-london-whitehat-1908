require "rack"

class Application
    @@items = []

    def call(env)
        resp = Rack::Response.new
        req  = Rack::Request.new(env)

        if req.path.match(/items/)
            req_item = req.path.split("/items/").last
            item = @@items.find { |item| item.name == req_item }
            if item
                resp.write item.price
            else
                resp.status = 400
                resp.write "Item not found"
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end

        resp.finish
    end
end