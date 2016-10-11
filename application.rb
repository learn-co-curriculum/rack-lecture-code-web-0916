class Application

  def call(env)
    req = Rack::Request.new(env)

    if req.get? && req.path == '/'
      render('/home/index.html.erb')
    elsif req.get? && req.path == '/books' && req.params['id']
      @book = Book.find(req.params['id'])
      render('/books/show.html.erb')
    elsif req.get? && req.path == '/books'
      @books = Book.all
      render('/books/index.html.erb')
    else
      res = Rack::Response.new('File not found', 404)
    end
  end

  private

  def render(file_path)
    res = Rack::Response.new
    template = File.read("./app/views#{file_path}")
    result = ERB.new(template).result(binding)
    res.write result
    res.finish
  end

end
