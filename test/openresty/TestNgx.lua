--
-- Created by IntelliJ IDEA.
-- User: lizhitao
-- Date: 2017/6/14
-- Time: 下午6:03
-- To change this template use File | Settings | File Templates.
--

-- 写响应头
ngx.header.a = 'a'
ngx.header.b = { 'b', 'c' }

--输出响应
ngx.say("a", "b", "<br/>")
ngx.print("c", "d", "<br/>")

--未经解码的请求uri
local request_uri = ngx.var.request_uri;
ngx.say("request_uri : ", request_uri, "<br/>");
--解码
ngx.say("decode request_uri : ", ngx.unescape_uri(request_uri), "<br/>");
ngx.say("aa= ", ngx.req.get_uri_args()['aa'], "</br>")
--MD5
ngx.say("ngx.md5 : ", ngx.md5("123"), "<br/>")
--http time
ngx.say("ngx.http_time : ", ngx.http_time(ngx.time()), "<br/>")

-- 200状态码退出
ngx.exit(200)
--ngx.redirect("http://jd.com", 302)
