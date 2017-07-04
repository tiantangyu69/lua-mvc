--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/6/20
-- Time: 下午4:46
-- To change this template use File | Settings | File Templates.
--
local HttpStatus = require('webframe.http.HttpStatus')

local testAPI = {}

-- 测试模板渲染
function testAPI.renderHtml(request, response)
    local data = {}
    data.message = 'hello, world! -- 你好，世界！'
    data.users = {
        { name = "Jane", age = 29 },
        { name = "John", age = 25 }
    }

    response:render('view.html', data)
end

-- 测试返回 json
function testAPI.jsonResult(request, response)
    response:writeJson({ ['username'] = '张三', ['sex'] = '男' })
end

-- 测试 restful api
function testAPI.restfulApi(request, response)
    local param1 = request:getParameter('param1')
    local param2 = request:getParameter('param2')
    local p1 = request:getParameter('p1')
    local p2 = request:getParameter('p2')

    response:writeTxt("param1: ", tostring(param1), '; param2: ', tostring(param2), '; p1: ', p1, '; p2: ', p2)
end

-- 测试基于 layout 的 html 渲染
function testAPI.renderLayout(request, response)
    local data = {}
    data.message = 'hello, world! -- 你好，世界！'
    response:renderWithLayout('viewWithLayout.html', 'layout.html', data, 'layout 测试')
end

-- 测试重定向
function testAPI.redirect(request, response)
    response:sendRedirect('http://www.163.com')
end

return testAPI