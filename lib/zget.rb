require "digest"
require "dnssd"
require "ipaddr"
require "open-uri"
require "securerandom"
require "socket"
require "webrick"

require "zget/command"
require "zget/command/zget"
require "zget/command/zput"
require "zget/errors"
require "zget/file_handler"
require "zget/version"

module Zget
  def self.get(file_or_alias: nil, output: nil)
    Zget.new(file_or_alias: file_or_alias, output: output).call
  end

  def self.put(_alias: SecureRandom.hex(2), bind_address: "0.0.0.0", file:, port: 6666)
    Zput.new(_alias: _alias, bind_address: bind_address, file: file, port: port).call
  end
end

