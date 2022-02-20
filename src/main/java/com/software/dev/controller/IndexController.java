package com.software.dev.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.software.dev.domain.Result;
import com.software.dev.domain.SysToken;
import com.software.dev.mapper.SysTokenMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

@RestController
@Slf4j
class IndexController {

    @Autowired
    SysTokenMapper sysTokenMapper;

    @GetMapping("/index")
    public Result index(){
        return Result.error("无法直接访问");
    }

    @PostMapping("/login")
    public Result loginActon(String token, HttpSession session){
        if(session.getAttribute("token")!=null){
            session.setAttribute("token",token);
            return Result.ok("已登录");
        }else if(StringUtils.isEmpty(token)&&token.length()<10){
            return Result.error("请输入合法的登录token");
        }else if(sysTokenMapper.selectCount(new QueryWrapper<SysToken>().eq("token_value",token))>0){
            session.setAttribute("token",token);
            return Result.ok("token有效，登录成功");
        }else{
            return Result.error("无效token");
        }
    }
}
