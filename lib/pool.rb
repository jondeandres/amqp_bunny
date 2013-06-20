require 'consumer'

class Pool
  attr_accessor :connection, :num_threads

  def initialize(num_threads = nil)
    @num_threads = num_threads || 2
    @connection = Bunny.new
  end

  def init
    connection.start
    num_threads.times { pool.async.run }
  end

  def pool
    @pool ||= Consumer.pool(size: num_threads, args: [connection])
  end
end
