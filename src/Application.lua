--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/6/14
-- Time: 下午5:35
-- mvc 主程序入口
--
local dispatcher = require('webframe.mvc.Dispatcher')
local requestMapping = require('webframe.mvc.mapping.RequestMapping')
local application = {}

-- 添加 GET 请求映射
local function initRequestMapping()
    requestMapping.addGetMapping('/testRenderHtml', 'renderHtml', 'api.TestAPI')
    requestMapping.addGetMapping('/testReturnJson', 'jsonResult', 'api.TestAPI')
    requestMapping.addGetMapping('/testRestfulApi/param1/{param1}/param2/{param2}', 'restfulApi', 'api.TestAPI')
    requestMapping.addGetMapping('/testRenderLayout', 'renderLayout', 'api.TestAPI')
    requestMapping.addGetMapping('/testRedirect', 'redirect', 'api.TestAPI')
end

initRequestMapping()

function application:run()
    dispatcher.dispatch(requestMapping.getMapping()) -- 分发请求
end

return application
