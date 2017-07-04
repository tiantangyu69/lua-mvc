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
    requestMapping.addGetMapping('/testlua2', 'getOneComment2', 'api.CommentAPI')
    requestMapping.addGetMapping('/testlua', 'getOneComment', 'api.CommentAPI')
    requestMapping.addGetMapping('/testlua/docId/{docId}/comments/{commentId}', 'getOneComment3', 'api.CommentAPI')
    requestMapping.addGetMapping('/testlua3', 'renderLayout', 'api.CommentAPI')
    requestMapping.addGetMapping('/testlua4', 'redirect', 'api.CommentAPI')
end

initRequestMapping()

function application:run()
    dispatcher.dispatch(requestMapping.getMapping()) -- 分发请求
end

return application
