--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/6/20
-- Time: 下午4:46
-- To change this template use File | Settings | File Templates.
--
local HttpStatus = require('webframe.http.HttpStatus')

local commentAPI = {}

function commentAPI.getOneComment(request, response)
    local data = {}
    data.message = 'hello, world! -- 你好，世界！'
    data.users = {
        { name = "Jane", age = 29 },
        { name = "John", age = 25 }
    }

    response:render('view.html', data)
end

function commentAPI.getOneComment2(request, response)
    response:writeJson({ ['username'] = '张三', ['sex'] = '男' })
end

function commentAPI.getOneComment3(request, response)
    local docId = request:getParameter('docId')
    local commentId = request:getParameter('commentId')
    local aaa = request:getParameter('aaa')
    local bbb = request:getParameter('bbb')

    response:writeTxt("docId: ", tostring(docId), '; commentId: ', tostring(commentId), '; aaa: ', aaa, '; bbb: ', bbb, '<br>')
end

function commentAPI.renderLayout(request, response)
    local data = {}
    data.message = 'hello, world! -- 你好，世界！'
    response:renderWithLayout('viewWithLayout.html', 'layout.html', data, 'layout 测试')
end

function commentAPI.redirect(request, response)
    response:sendRedirect('http://www.163.com')
end

return commentAPI