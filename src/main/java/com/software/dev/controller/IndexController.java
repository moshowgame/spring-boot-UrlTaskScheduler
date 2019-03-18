package com.software.dev.controller;

import com.software.dev.domain.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Slf4j
public class IndexController {

    @RequestMapping("/index")
    public String index(){
        return "index";
    }
    @RequestMapping("/page")
    public String page(){
        return "urlrequest-list";
    }

    @ResponseBody
    @RequestMapping("/login")
    public Object login(String username,String password){
        log.info("username:"+username);
        log.info("password:"+password);
        return Result.ok("登录成功");
    }
}
