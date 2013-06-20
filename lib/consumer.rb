require 'bunny'
require 'msgpack'
require 'json'
require 'celluloid/autostart'

class Consumer
  include Celluloid

  attr_reader :connection, :channel, :queue

  def initialize(connection)
    @connection = connection
  end

  def channel
    @channel ||= connection.create_channel
  end

  def queue
    @queue ||= channel.queue('payments', durable: true, auto_delete: false)
  end

  def run
    puts "New thread!"
    queue.subscribe(block: true) do |delivery_info, properties, payload|
      msg = MessagePack.unpack(payload)
      value = msg['params']['value']
      # puts "From: #{Thread.current} #{value}"
    end
  end

end
