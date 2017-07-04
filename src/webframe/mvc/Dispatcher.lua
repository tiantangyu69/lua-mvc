--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/6/20
-- Time: 下午5:58
-- To change this template use File | Settings | File Templates.
--
local mappingResolver = require('webframe.mvc.mapping.MappingResolver')
local Request = require('webframe.http.Request')
local Response = require('webframe.http.Response')
local invoker = require('webframe.mvc.invoker.FunctionInvoker')
local HttpStatus = require('webframe.http.HttpStatus')

local dispatcher = {}

-- 执行请求分发
local function doDispatch(mappingFunc, request, response)
    local success = invoker.invokeFunction(mappingFunc, request, response) -- 执行函数调用

    if not success then -- 执行函数失败
        -- 函数执行失败返回 500
        response:sendError(HttpStatus.SC_INTERNAL_SERVER_ERROR)
    end
end

-- 请求分发
function dispatcher.dispatch(mappings)
    local request = Request:new()
    local response = Response:new()
    local mappingFunc = mappingResolver.resolve(request, mappings)

    if mappingFunc then -- 找到控制器映射的函数，执行请求分发
        doDispatch(mappingFunc, request, response)
    else
        -- 未找到控制器映射的函数返回 404
        response:sendError(HttpStatus.SC_NOT_FOUND)
    end
end

return dispatcher

