package com.software.dev.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;

/**
 *  url_request
 * @author 大狼狗 2019-03-11
 */
@Data
public class UrlRequest implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 请求id
     */
    @TableId(type = IdType.ID_WORKER_STR)
    private String requestId;

    /**
     * 请求名称
     */
    private String requestName;

    /**
     * 触发时间cron表达式
     */
    private String requestCron;

    /**
     * 请求url
     */
    private String requestUrl;

    /**
     * 请求方法，get/post
     */
    private String requestMethod;

    /**
     * 启用状态
     */
    private Integer status;
    /**
     * 超时时间ms
     */
    private Integer requestTimeout;

    @TableField(exist = false)
    private String triggerState;

    @TableField(exist = false)
    private  String nextFireTime;

    public UrlRequest() {
    }
    @Data
    public static class RequestMethod{
        public static String GET="GET";
        public static String POST="POST";
    }
}