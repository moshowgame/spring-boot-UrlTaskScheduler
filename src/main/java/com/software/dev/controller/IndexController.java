package com.software.dev.controller;

import com.software.dev.domain.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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

    @RequestMapping("/log/page")
    public ModelAndView logPage(@RequestParam(required = true) String requestId){
        ModelAndView mav = new ModelAndView("urlresponse-list");
        mav.addObject("requestId",requestId);
        return mav;
    }

    @ResponseBody
    @RequestMapping("/login")
    public Object login(String username,String password){
        log.info("username:"+username);
        log.info("password:"+password);
        return Result.ok("登录成功");
    }
}
