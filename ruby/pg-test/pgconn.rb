require 'pg'

class PGClient
  attr_accessor :conn, :io
  def initialize
    conn = PGconn.new({host: 'localhost', user: 'tzhu', dbname: 'case_manager_development'})
    conn.setnonblocking(true)
    io = IO.new(conn.socket)
  end

  def process_command
    # later
    conn.consume_input
    unless conn.is_busy
      res, data = 0, []
      while res != nil
        res = get_result
        res.each {|d| data.push d} unless res.nil?
      end
    end
    puts data
  end

  loop do
    res = select([io], nil, nil, 0.001)
    process_command unless res.nil?
  end
end
