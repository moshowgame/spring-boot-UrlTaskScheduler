package com.software.dev.domain;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import java.util.Date;
import java.util.List;

/**
 *  url_response
 * @author 大狼狗 2019-03-15
 */
@Data
public class UrlResponse implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 响应id
     */
    @TableId(type = IdType.AUTO)
    private String responseId;

    /**
     * 请求id
     */
    private String requestId;

    /**
     * 应答时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss.SSS", timezone = "GMT+8")
    private Date responseTime;
    /**
     * 请求时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss.SSS", timezone = "GMT+8")
    private Date requestTime;

    /**
     * 响应内容
     */
    private String responseText;

    /**
     * 状态：0失败 1成功 9无响应
     */
    private Integer status;
    /**
     * 推断结果
     */
    private String assumptionResult;

    public UrlResponse() {
    }

}