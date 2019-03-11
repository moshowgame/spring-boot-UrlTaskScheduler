package com.software.dev.domain;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import java.util.Date;
import java.util.List;

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
    @TableId
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

    public UrlRequest() {
    }
    @Data
    public static class RequestMethod{
        public static String GET="GET";
        public static String POST="POST";
    }
}