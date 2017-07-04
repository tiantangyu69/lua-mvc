--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/6/15
-- Time: 下午8:39
-- To change this template use File | Settings | File Templates.
--
ngx.say("count: <br>")

local sharded_data = ngx.shared.shared_data

local i = sharded_data:get('i')
ngx.say('i = ', i, '<br>')

if not i then
    i = 1
    sharded_data:set('i', i)
    ngx.say('lazy set i', i, '</br>')
end

i = sharded_data:incr('i', 1)
ngx.say('i = ', i, '</br>')

value, flags, stale = sharded_data:get_stale('i')
ngx.say(value, ', ', flags, ',', stale)
