module Zget
  # We want this server to shutdown as soon as the file is downloaded
  class FileHandler < WEBrick::HTTPServlet::DefaultFileHandler
    def do_GET(request, response)
      response["Content-Disposition"] = "inline; filename=#{File.basename @local_path}"
      super
      @server.shutdown
    end
  end
end

