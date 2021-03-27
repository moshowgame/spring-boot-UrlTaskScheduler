package com.software.dev.controller;

import com.software.dev.domain.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@RestController
@Slf4j
class IndexController {

    @GetMapping("/index")
    public ModelAndView index(){
        return new ModelAndView("index");
    }

    @GetMapping("/request/list")
    public ModelAndView requestListPage(){
        return new ModelAndView("page/request-list");
    }

    @GetMapping("/token/detail")
    public ModelAndView tokenDetail(@RequestParam(required = true) String requestId){
        ModelAndView mav = new ModelAndView("task/token-detail");
        mav.addObject("requestId",requestId);
        return mav;
    }
/*    @RequestMapping("/page")
    public String page(){
        return "urlrequest-list";
    }

    @RequestMapping("/log/page")
    public ModelAndView logPage(@RequestParam(required = true) String requestId){
        ModelAndView mav = new ModelAndView("urlresponse-list");
        mav.addObject("requestId",requestId);
        return mav;
    }

    @GetMapping("/login")
    public ModelAndView loginPage(){
        return new ModelAndView("login");
    }
    @GetMapping("/index")
    public ModelAndView index(){
        log.info("GOTO INDEX");
        return new ModelAndView("index");
    }
    @GetMapping("/main")
    public ModelAndView main(){
        return new ModelAndView("main");
    }

    @ResponseBody
    @PostMapping("/login")
    public Object loginAcion(String username,String password){
        log.info("username:"+username);
        log.info("password:"+password);
        return Result.ok("登录成功");
    }

    @RequestMapping("/token/detail")
    public ModelAndView tokenDetail(@RequestParam(required = true) String requestId){
        ModelAndView mav = new ModelAndView("token-detail");
        mav.addObject("requestId",requestId);
        return mav;
    }*/
}
