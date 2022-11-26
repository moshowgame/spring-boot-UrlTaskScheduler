       /*
        * Decompiled with CFR.
        * 
        * Could not load the following classes:
        *  com.software.dev.domain.Result
        */
       package com.software.dev.controller;
       
       import com.software.dev.domain.Result;
       import java.util.HashMap;
       import org.slf4j.Logger;
       import org.slf4j.LoggerFactory;
       import org.springframework.web.bind.annotation.GetMapping;
       import org.springframework.web.bind.annotation.PostMapping;
       import org.springframework.web.bind.annotation.RequestMapping;
       import org.springframework.web.bind.annotation.RestController;
       
       @RestController
       @RequestMapping(value={"/demo"})
       public class DemoController {
           private static final Logger log = LoggerFactory.getLogger(DemoController.class);
           private String defaultToken = "zhengkai.blog.csdn.net";
       
           @GetMapping(value={"/token"})
           public Result getToken(String username, String password) {
/*20*/         log.info("username:{},password:{}", (Object)username, (Object)password);
               HashMap<String, String> resultMap = new HashMap<String, String>(2);
/*22*/         resultMap.put("token", this.defaultToken);
/*23*/         return Result.ok(resultMap);
           }
       
           @PostMapping(value={"/request"})
           public Result getRequest(String token) {
/*28*/         if (token != null && this.defaultToken.equals(token.trim())) {
/*29*/             return Result.ok((String)"请求成功，TOKEN有效");
               }
               return Result.error((String)("请求失败，TOKEN不正确：" + token));
           }
       }

