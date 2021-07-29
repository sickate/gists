require 'benchmark'
require 'fiber'

f1=Fiber.new do
  while true
    Fiber.yield
  end
end

f2=Fiber.new do
  while true
    Fiber.yield
  end
end

COUNT=50000000

Benchmark.bm do |x|
  x.report{
    COUNT.times do
      f1.resume
      f2.resume
    end
  }
end
