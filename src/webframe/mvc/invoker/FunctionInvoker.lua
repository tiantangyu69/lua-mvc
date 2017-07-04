--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/6/26
-- Time: 下午2:58
-- To change this template use File | Settings | File Templates.
--
local invoker = {}

function invoker.invokeFunction(func, request, response)
    local res, result, err = pcall(func, request, response)

    if not res then
        ngx.log(ngx.ERR, 'invoke function: ', tostring(func) .. ', error cause: ', err)
    end

    return res, result, err
end

return invoker