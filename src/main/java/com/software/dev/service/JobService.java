package com.software.dev.service;

import lombok.extern.slf4j.Slf4j;
import org.quartz.*;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.Date;

/**
 * Job 的实例要到该执行它们的时候才会实例化出来。每次 Job 被执行，一个新的 Job 实例会被创建。
 * 其中暗含的意思就是你的 Job 不必担心线程安全性，因为同一时刻仅有一个线程去执行给定 Job 类的实例，甚至是并发执行同一 Job 也是如此。
 * @DisallowConcurrentExecution 保证上一个任务执行完后，再去执行下一个任务
 */
@DisallowConcurrentExecution
@Service
@Slf4j
public class JobService implements Job, Serializable {
    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {

        log.info("Job is executing."+new Date() );
        //取得job详情
        JobDetail jobDetail = context.getJobDetail();
        // 取得job名称
        String jobName = jobDetail.getClass().getName();
        log.info("Name: " + jobDetail.getClass().getSimpleName());
        //取得job的类
        log.info("Job Class: " + jobDetail.getJobClass());
        //取得job开始时间
        log.info(jobName + " fired at " + context.getFireTime());
        //取得job下次触发时间
        log.info("Next fire time " + context.getNextFireTime());

        JobDataMap dataMap =  jobDetail.getJobDataMap();

        log.info("itstyle: " + dataMap.getString("itstyle"));
        log.info("blog: " + dataMap.getString("blog"));
        String[] array = (String[]) dataMap.get("data");
        for(String str:array){
            log.info("data: " + str);
        }
        //测试效果 保证上一个任务执行完后，再去执行下一个任务
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }
}
