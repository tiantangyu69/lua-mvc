--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/7/4
-- Time: 下午5:37
-- To change this template use File | Settings | File Templates.
--
local red = require('resty.redis')


local Redis = {}

function Redis:new(config)
    local instance = {}

    config = config or {
        ['host'] = 'localhost',
        ['port'] = 6379,
        ['auth'] = nil,
        ['timeout'] = 5000,
        ['database'] = 0
    }

    instance.config = config

    setmetatable(instance, { __index = self })

    return instance;
end

local function connect(config)
    local redis = red:new()
    red:set_timeout(config.timeout)

    local ok, err = red:connect(config.host, config.port)

    if not ok then
        ngx.say("failed to connect: ", err)
        return
    end
end

return Redis

