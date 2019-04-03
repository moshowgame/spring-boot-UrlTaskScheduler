# EasyUrlTask
----
EasyUrlTask也叫EasyUrlJob、EasyUrlSchedule，基于Quartz 2.3 and SpringBoot2 的URL接口调度平台，支持集群。公司日常的很多任务调度其实都可以简化为基于URL的调度方式，EasyUrlTask也就因此而生，简化日常URL调度任务，并简单管理这些请求。

EasyUrlTask的核心是什么？
----
Quartz+SpringBoot是系统的基础，URL Request是核心调度封装，包含TokenAddition（Header Token、Form Token、Url Token）、RequestParam（FormData或JSON，GET/POST）、ResponseAssert（响应断言，根据返回结果判断是否成功，例如设置keyword="code":"00",state=1，匹配到返回对象包含keyword则代表成功，否则失败）。



T_TASK_TRIGGERS表 TRIGGER_STATE字段
----
- WAITING:等待  
- PAUSED:暂停 
- ACQUIRED:正常执行 
- BLOCKED：阻塞 
- ERROR：错误

#####目前进度40%
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
- response log√
- login html
- list html
- ui component
- code optimization
