class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    path = req.path

    if path.match(/items/)
      item_name = path.split('/').last
      matches = @@items.select { |item| item.name == item_name }
      if matches.empty?
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write "#{matches[0].price}"
      end

    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

end
