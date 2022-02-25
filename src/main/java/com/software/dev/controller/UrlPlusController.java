package com.software.dev.controller;

import cn.hutool.core.map.MapUtil;
import cn.hutool.http.HttpUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.software.dev.domain.PageParam;
import com.software.dev.domain.Result;
import com.software.dev.domain.UrlRequestToken;
import com.software.dev.domain.UrlResponseAssumption;
import com.software.dev.mapper.UrlRequestTokenMapper;
import com.software.dev.mapper.UrlResponseAssumptionMapper;
import com.software.dev.service.UrlPlusService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * UrlPlus Controller
 * 封装增强处理器
 * @author zhengkai@blog.csdn.net/moshowgame
 * @date 2019/04/28
 */
@RestController
@Slf4j
@RequestMapping("/urlPlus")
public class UrlPlusController {

    @Autowired
    private UrlRequestTokenMapper urlRequestTokenMapper;
    @Autowired
    private UrlResponseAssumptionMapper urlResponseAssumptionMapper;

    @Autowired
    private UrlPlusService urlPlusService;

    @PostMapping("/token/info")
    public Result tokenQuery(@RequestBody PageParam pageParam){
        UrlRequestToken urlRequestToken=urlRequestTokenMapper.selectById(pageParam.getRequestId());
        if(urlRequestToken==null){
            return Result.error("找不到对应的token，新建一个吧");
        }else{
            return Result.ok(urlRequestToken);
        }
    }
    @PostMapping("/assumption/info")
    public Result assumptionQuery(@RequestBody PageParam pageParam){
        UrlResponseAssumption urlResponseAssumption=urlResponseAssumptionMapper.selectById(pageParam.getRequestId());
        if(urlResponseAssumption==null){
            return Result.error("找不到对应的assumption，新建一个吧");
        }else{
            return Result.ok(urlResponseAssumption);
        }
    }

    @PostMapping("/token/test")
    public Result tokenTest(@RequestBody PageParam pageParam){
        UrlRequestToken urlRequestToken=urlRequestTokenMapper.selectById(pageParam.getRequestId());
        if(urlRequestToken==null){
            return Result.error("找不到对应的token");
        }else{
            try {
                return Result.ok(urlPlusService.getToken(urlRequestToken));
            }catch (Exception e){
                return Result.error("请求失败:"+e.getMessage());
            }
        }
    }
    /**
     * 新增或编辑
     */
    @PostMapping("/token/save")
    public Result tokenSave(@RequestBody UrlRequestToken urlRequestToken){
        log.info("tokenSaveOrUpdate:"+urlRequestToken.getRequestId());
        if(StringUtils.isAnyEmpty(urlRequestToken.getRequestId(),urlRequestToken.getParam(),urlRequestToken.getTokenUrl())){
            return Result.error("请完善信息后提交");
        }
        if(urlRequestTokenMapper.selectById(urlRequestToken.getRequestId())!=null){
            urlRequestTokenMapper.updateById(urlRequestToken);
        }else{
            urlRequestTokenMapper.insert(urlRequestToken);
        }
        return Result.ok("TOKEN保存成功");
    }
    @PostMapping("/assumption/save")
    public Result assumptionSave(@RequestBody UrlResponseAssumption urlResponseAssumption){
        log.info("assumptionSaveOrUpdate:"+urlResponseAssumption.getRequestId());
        if(StringUtils.isAnyEmpty(urlResponseAssumption.getRequestId(),urlResponseAssumption.getKeyFirst(),urlResponseAssumption.getValueFirst(),urlResponseAssumption.getValueElse())){
            return Result.error("请完善信息后提交");
        }
        if(urlResponseAssumptionMapper.selectById(urlResponseAssumption.getRequestId())!=null){
            urlResponseAssumptionMapper.updateById(urlResponseAssumption);
        }else{
            urlResponseAssumptionMapper.insert(urlResponseAssumption);
        }
        return Result.ok("ASSUMPTION保存成功");
    }
}
