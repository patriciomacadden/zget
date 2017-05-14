module Zget
  class Zget < Command
    attr_reader :file_or_alias, :output

    CONTENT_LENGTH_PROC = ->(content_length) { @content_length = content_length }
    PROGRESS_PROC = ->(size) do
      percentage = size * 100 / @content_length
      print "\rDownloading: #{percentage}%"
      puts "\n" if percentage == 100
    end

    def initialize(file_or_alias: nil, output: nil)
      @content_length = 0
      @file_or_alias = file_or_alias
      @output = output
    end

    def call
      if file_or_alias.nil?
        @file_or_alias = SecureRandom.hex 2
        puts "Upload a file using `zput <filename> #{file_or_alias}`"
      else
        puts "Upload a file using `zput #{file_or_alias}` or `zput <filename> #{file_or_alias}`"
      end

      services = []
      DNSSD.browse! "_http._tcp" do |reply|
        services << reply

        next if reply.flags.more_coming?

        service = services.detect { |s| s.name == hash }

        unless service.nil?
          DNSSD.resolve! service do |r|
            open url(r), content_length_proc: CONTENT_LENGTH_PROC, progress_proc: PROGRESS_PROC do |f|
              filename = output || f.meta["content-disposition"].split(";").last.split("=").last
              File.write filename, f.read
            end
            break
          end
        end
        break
      end
    end

    private

    def hash
      Digest::SHA1.hexdigest File.basename(file_or_alias)
    end

    def url(reply)
      info = Socket.getaddrinfo(reply.target, nil, Socket::AF_INET)
      host = info[0][2]

      "http://#{host}:#{reply.port}"
    end
  end
end

