package com.software.dev.domain;

import java.io.Serializable;
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
    private String responseId;

    /**
     * 请求id
     */
    private String requestId;

    /**
     * 应答时间
     */
    private Date responseTime;

    /**
     * 响应内容
     */
    private String responseText;

    /**
     * 状态：0失败 1成功 9无响应
     */
    private Integer state;

    public UrlResponse() {
    }

}