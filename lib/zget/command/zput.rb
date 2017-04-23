module Zget
  class Zput < Command
    attr_reader :alias, :bind_address, :file, :port

    def initialize(_alias: SecureRandom.hex(2), bind_address: "0.0.0.0", file:, port: 6666)
      @bind_address = IPAddr.new bind_address
      @file = file.tap do |f|
        raise InvalidFileError unless File.exist? f
      end
      @alias = _alias
      @port = port.tap do |p|
        raise InvalidPortError unless p.between? 0, 65535
      end
    end

    def call
      puts "Download this file using `zget #{File.basename file}` or `zget #{@alias}`"

      hashes.each do |hash|
        DNSSD.register hash, "_http._tcp", nil, port
      end

      server.start
    end

    private

    def hashes
      [
        Digest::SHA1.hexdigest(File.basename(file)),
        Digest::SHA1.hexdigest(@alias)
      ]
    end

    def server
      @server ||= WEBrick::HTTPServer.new(AccessLog: [], BindAddress: bind_address.to_s, Logger: WEBrick::Log.new("/dev/null"), Port: port).tap do |s|
        s.mount "/", FileHandler, file
        trap("INT") { s.shutdown }
      end
    end
  end
end

