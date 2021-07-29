c1=coroutine.create(function ()
                     while true do
                       coroutine.yield()
                     end
                    end)

c2=coroutine.create(function ()
                     while true do
                       coroutine.yield()
                     end
                    end)

local start=os.clock()
local count=50000000

for i=1,count do
 coroutine.resume(c1)
 coroutine.resume(c2)
end

print(4*count/(os.clock()-start))
