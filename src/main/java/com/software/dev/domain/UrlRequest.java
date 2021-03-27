package com.software.dev.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

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
    /**
     * 更新时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;

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

    @Data
    /**
     *                      case 0:return '停止';
     *                     case 1:return '启动';
     *                     case  2:return '禁用';
     *                     case 3:return '暂停';
     * */
    public static class RequestStatus{
        public static Integer STOP=0;
        public static Integer START=1;
    }
}