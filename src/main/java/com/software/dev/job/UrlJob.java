package com.software.dev.job;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.http.HttpUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.software.dev.domain.UrlRequest;
import com.software.dev.domain.UrlResponse;
import com.software.dev.mapper.UrlRequestMapper;
import com.software.dev.mapper.UrlResponseMapper;
import lombok.extern.slf4j.Slf4j;
import org.quartz.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.io.Serializable;
import java.util.Date;

/**
 * UrlPlugin之UrlJob
 * @author  zhengkai@blog.csdn.net/moshowgame
 * * @DisallowConcurrentExecution 保证上一个任务执行完后，再去执行下一个任务
 */
@DisallowConcurrentExecution
@Slf4j
@Component
public class UrlJob  implements Job, Serializable {

    private static final long serialVersionUID = 1L;

    public static String DEFAULT_GROUP="DEFAULT";

    @Autowired
    private UrlResponseMapper urlResponseMapper;
    @Autowired
    private UrlRequestMapper urlRequestMapper;

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {

        log.info("EasyUrlTask is executing the job:"+ DateUtil.now());
        //取得job详情
        JobDetail jobDetail = context.getJobDetail();
        // 取得job名称
        //String jobName = jobDetail.getClass().getName();
        //log.info("Job Name:" + jobName);
        //取得job的类 ，由于UrlPlugin是同个class不同参数，所以这里都是同个class
        //log.info("Job Class:" + jobDetail.getJobClass());
        //取得job开始时间
        //log.info("start/fire time: " + DateUtil.formatHttpDate(context.getFireTime()));
        //取得job下次触发时间
        log.info("Next fire time :" + DateUtil.formatHttpDate(context.getNextFireTime()));

        JobDataMap dataMap =  jobDetail.getJobDataMap();
        String urlId=dataMap.getString("requestId");
        log.info("URL REQUEST ID: " + urlId);

        String responseMsg=null;
        //Url Request
        if(!StringUtils.isEmpty(urlId)){
            UrlRequest urlRequest=urlRequestMapper.selectOne(new QueryWrapper<UrlRequest>().eq("request_id",urlId));
            //成功找到请求id
            if(urlRequest!=null){
                log.info("URL REQUEST NAME: " + urlRequest.getRequestName());
                log.info(urlRequest.getRequestMethod()+":" + urlRequest.getRequestUrl());
                //请求GET/POST
                if(UrlRequest.RequestMethod.GET.equals(urlRequest.getRequestMethod())){
                    responseMsg = HttpUtil.get(urlRequest.getRequestUrl());
                }else if (UrlRequest.RequestMethod.POST.equals(urlRequest.getRequestMethod())){
                    responseMsg = HttpUtil.post(urlRequest.getRequestUrl(),"");
                }
                log.info("RESPONSE TEXT:"+responseMsg);

                //处理响应
                UrlResponse urlResponse=new UrlResponse();
                urlResponse.setRequestId(urlId);
                urlResponse.setResponseId(IdUtil.fastUUID());
                urlResponse.setResponseTime(new Date());
                urlResponse.setResponseText(responseMsg);
                urlResponseMapper.insert(urlResponse);

            }
        }


    }
}
