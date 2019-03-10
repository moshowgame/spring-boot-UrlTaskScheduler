package com.software.dev;

import lombok.extern.slf4j.Slf4j;
import org.quartz.SchedulerException;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author zhengkai
 */
@SpringBootApplication
@Slf4j
public class Application {

    public static void main(String[] args) throws InterruptedException, SchedulerException {
        SpringApplication.run(Application.class, args);
        log.info("项目启动 ");
    }
}