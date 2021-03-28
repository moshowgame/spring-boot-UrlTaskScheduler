package com.software.dev.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
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

    @GetMapping("/token/list")
    public ModelAndView tokenListPage(){
        return new ModelAndView("page/token-list");
    }

    @GetMapping("/token/detail")
    public ModelAndView tokenDetail(@RequestParam(required = true) String requestId){
        log.info("requestId:{}",requestId);
        ModelAndView mav = new ModelAndView("page/token-detail");
        mav.addObject("requestId",requestId);
        return mav;
    }
    @GetMapping("/response/list")
    public ModelAndView responsePage(@RequestParam(required = true) String requestId){
        ModelAndView mav = new ModelAndView("page/response-list");
        mav.addObject("requestId",requestId);
        return mav;
    }
}
