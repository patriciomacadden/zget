module Zget
  # We want this server to shutdown as soon as the file is downloaded
  class FileHandler < WEBrick::HTTPServlet::DefaultFileHandler
    # We want to trick `Kernel::open` in order to display the upload progress.
    # We do so by reading the file in chunks rather than the whole file.
    # Why trick `Kernel::open`? See: https://github.com/ruby/ruby/blob/trunk/lib/webrick/httpservlet/filehandler.rb#L61
    def open(path, mode)
      st = File::stat(@local_path)
      Kernel.open(path, mode) do |io|
        data = ""
        while d = io.read(1024 * 8)
          data << d
          percentage = data.size * 100 / st.size
          print "\rUploading: #{percentage}%"
          puts "\n" if percentage == 100
        end
        data
      end
    end

    def do_GET(req, res)
      res["Content-Disposition"] = "inline; filename=#{File.basename @local_path}"
      super
      @server.shutdown
    end
  end
end

