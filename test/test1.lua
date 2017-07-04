--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/6/19
-- Time: 下午8:10
-- To change this template use File | Settings | File Templates.
--
mt = {}
print('mt metatable: ' .. tostring(getmetatable(mt)))

t = { ['a'] = true, ['b'] = 'aaaa' }

setmetatable(mt, { __index = t })
print('mt metatable: ' .. tostring(getmetatable(mt)))


print(t.a)
print(mt.b)

print('10' + '1')
print('10' == 10)