God.watch do |w|
  w.name = "simple"
  w.start = "ruby /Users/tzhu/workspace/lab/god-test/simple.rb"
  w.keepalive(memory_max: 150.megabytes,
              cpu_max: 50.percent)
end
