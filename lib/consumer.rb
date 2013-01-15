require 'bunny'
require 'msgpack'

class Consumer
  attr_reader :connection, :channel, :queue
  def initialize
    connect
  end

  def connect
    # Create and start the connection with RabbitMQ
    @connection = Bunny.new
    @connection.start

    # Create a channel
    @channel = @connection.create_channel
    # Create a queue with default_exchange: 'direct exchange'
    @queue = @channel.queue('payments', durable: true, auto_delete: false)
  end

  private :connect
require 'json'
  def run
    queue.subscribe(block: true) do |delivery_info, properties, payload|
      msg = MessagePack.unpack(payload)
      puts msg['params']['value']
    end
  end

end
