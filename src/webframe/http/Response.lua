--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/6/20
-- Time: 下午4:20
-- To change this template use File | Settings | File Templates.
--
local json = require('cjson')
local template = require("webframe.mvc.view.template")
local Response = {}

Response.version = '0.0.1'

function Response:new()
    local instance = {
        status = 200
    }

    setmetatable(instance, { __index = self })

    return instance
end

function Response:write(...)
    ngx.say(...)
end

-- 写纯文本数据 content_type: text/plain
function Response:writeTxt(...)
    self:setHeader('content_type', 'text/plain;charset=utf-8')
    ngx.say(...)
end

-- 写 html 数据 content_type: text/html
function Response:render(view, data)
    self:setHeader('content_type', 'text/html;charset=utf-8')
    template.render(view, data)
end

function Response:renderWithLayout(view, layout, data, title)
    title = title or 'OpenResty'

    self:setHeader('content_type', 'text/html;charset=utf-8')
    template.render(layout, {
        title = title,
        view = template.compile(view)(data)
    })
end

-- 写 json 数据 content_type: application/json
function Response:writeJson(object)
    self:setHeader('content_type', 'application/json;charset=utf-8')
    local jsonStr = json.encode(object)
    ngx.say(jsonStr)
end

function Response:sendError(httpStatus)
    ngx.exit(httpStatus)
end

function Response:sendRedirect(location)
    ngx.redirect(location)
end

function Response:setHeader(name, value)
    ngx.header[name] = value
end

function Response:setStatus(status)
    if status and pcall(tonumber, status) then
        self.status = status
    end
end

function Response:getStatus()
    return self.status
end

--function Response:addCookie(cookie)
--
--end

return Response

