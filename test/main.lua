--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/6/14
-- Time: 下午4:23
-- To change this template use File | Settings | File Templates.
--
local json = require("cjson")

local main = {}

function main:run()
    ngx.say(json.encode("I am main function"))
end

return main
