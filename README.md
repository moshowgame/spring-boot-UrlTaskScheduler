# spring-boot-EasyUrlTask
什么是EasyUrlTask？
----
EasyUrlTask也叫EasyUrlJob、EasyUrlSchedule，基于Quartz 2.3 and SpringBoot2 的URL接口调度平台，支持集群。

EasyUrlTask的核心是什么？
----
Quartz是系统的基础，URL Request Plugin是核心调度封装。

URL Request Plugin
----
包含Request Loader（TokenAddition、RequestParam、ResponseAssert）、WebAdminUI。

TokenAddition追加Token方式
----
Header Token、Form Token、Url Token，三种追加token的方式，部分系统的token是不一样的，甚至可能要针对参数做加密，这里只针对固定token，其他情况可能需要做个例外，或者多做一些支持。

RequestParam
----
请求参数，表单或JSON，GET/POST。

ResponseAssert
----
响应断言，根据返回结果判断是否成功，例如设置{"code":"00"}，匹配到返回对象有code=00则代表成功，否则失败。

#####目前进度25%
- quartz√
- druid√
- springboot2√
- fastjson√
- mybatis-plus√
- url request loader√
- demo request test√
- request token
- request params
- request assert
- response log
- login html
- list html
- ui component
- code optimization
