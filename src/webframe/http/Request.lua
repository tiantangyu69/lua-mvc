--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/6/19
-- Time: 下午8:21
-- To change this template use File | Settings | File Templates.
--
local Request = {}

Request.version = '0.0.1'

-- 创建 Request 对象
function Request:new()
    local instance = {
        _req = ngx.req,
        parameter = {},
        attribute = {}
    }

    setmetatable(instance, { __index = self })

    return instance
end

-- 获取 http 请求方式
function Request:getMethod()
    if self.method then
        return self.method
    else
        self.method = self._req.get_method()
        return self.method
    end
end

-- 获取 http 请求头
function Request:getHeaders()
    if self.headers then
        return self.headers
    else
        self.headers = self._req.get_headers()
        return self.headers
    end
end

-- 获取指定的 http 请求头
function Request:getHeader(name)
    if not name then
        return nil
    else
        return self:getHeaders()[name]
    end
end

-- 获取原生未处理过的 header
function Request:getRawHeader()
    if self.raw_header then
        return self.raw_header
    else
        self.raw_header = self._req.raw_header()
    end
end

-- 设置请求参数
function Request:setParameter(name, value)
    self.parameter[name] = value
end

-- 获取请求参数
function Request:getParameter(name)
    if not name then
        return nil
    else
        if self.parameter[name] then
            return self.parameter[name]
        end

        method = self:getMethod()

        if method == 'POST' then
            self._req.read_body()
            return self._req.get_post_args()[name]
        else
            return self._req.get_uri_args()[name]
        end
    end
end

-- 设置请求属性
function Request:setAttribute(name, value)
    self.attribute[name] = value
end

-- 获取请求属性
function Request:getAttribute(name)
    if not name then
        return nil
    else
        return self.attribute[name]
    end
end

-- 获取请求的 http 版本
function Request:getHttpVersion()
    return self._req.http_version()
end

-- 获取请求的 uri
function Request:getRequestURI()
    return ngx.var.request_uri
end

-- 获取 uri
function Request:getURI()
    return ngx.var.uri
end

function Request:getBodyData()
    return self._req.get_body_data()
end

return Request
