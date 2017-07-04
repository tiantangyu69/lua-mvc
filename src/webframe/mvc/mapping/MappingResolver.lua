--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/6/20
-- Time: 下午6:12
-- To change this template use File | Settings | File Templates.
--
local match = ngx.re.match

local resolver = {}

-- 请求方法和映射是否匹配
local function isMatchRequestMethod(request, mapping)
    local method = request:getMethod() -- 请求方式
    local requestMethod = mapping.requestMethod -- 控制器的请求方法

    if requestMethod == method then -- 请求方法不匹配
        return true
    else
        return false
    end
end

-- 检查请求路径是否与控制器映射的地址匹配
local function isMatchRequestPath(request, mapping)
    local uri = request:getURI() -- 请求的 uri
    local matcher = match(uri, mapping.regPath)
    if matcher then -- 匹配映射路径成功
        local pathVariables = mapping.pathVariables
        if table.getn(pathVariables) > 0 then
            for index, pathVariable in pairs(pathVariables) do
                request:setParameter(pathVariable, matcher[index]) -- 设置 pathVariable 属性和值到 request 对象中
            end
        end

        return true
    else
        ngx.log(ngx.DEBUG, 'not mapping with uri: ', uri)
        return false
    end
end

-- 获取请求映射的 lua 函数
local function requireRequestAPI(mapping)
    local func = mapping.func -- 控制器映射的函数名称
    local filePath = mapping.filePath -- 控制器所在文件路径
    local success, module, err = pcall(require, filePath)

    if success then
        if module[func] then
            return module[func]
        else
            return nil
        end
    else
        ngx.log(ngx.ERR, err)
        return nil
    end
end

-- 执行解析请求映射
local function doResolveMapping(request, mapping)
    -- 请求方法和映射是否匹配
    if not isMatchRequestMethod(request, mapping) then
        return nil
    end

    -- 检查请求路径是否与控制器映射的地址匹配
    if not isMatchRequestPath(request, mapping) then
        return nil
    end

    -- 获取请求映射的 lua 函数
    return requireRequestAPI(mapping)
end

function resolver.resolve(request, mappings)
    local mappingFunc; -- 映射的函数
    for _, mapping in pairs(mappings) do
        mappingFunc = doResolveMapping(request, mapping)

        if mappingFunc then -- 找到映射的函数，直接返回函数
            break
        end
    end

    return mappingFunc
end

return resolver;

