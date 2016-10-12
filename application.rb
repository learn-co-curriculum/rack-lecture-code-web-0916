class Application

  def call(env)
    request = Rack::Request.new(env)
    if request.get? && request.path == '/'
      render('index.html.erb')
    elsif request.get? && request.path == '/books' && request.params["id"]
      @book = Book.find(request.params["id"])
      render('books/show.html.erb')
    elsif request.get? && request.path == '/books'
      @books = Book.all
      render('books/index.html.erb')
    else
      response = Rack::Response.new('<h1>Nothing here</h1>', 404)
    end
  end

  private

  def render(file_path)
    template = File.read("./app/views/#{file_path}")
    result = ERB.new(template).result(binding)
    response = Rack::Response.new(result)
  end

end
