--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/6/19
-- Time: 下午8:10
-- To change this template use File | Settings | File Templates.
--
local mt = {}
-- default has not metatable
print('mt metatable: ' .. tostring(getmetatable(mt)))

local t = { ['a'] = true }
setmetatable(mt, { __index = t })
print('set mt metatable t, mt metatable: ' .. tostring(getmetatable(mt)))

--mt.__index = t

print('t.a:', t.a)
print('mt.a:', mt.a)