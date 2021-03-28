package com.software.dev.domain;
import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import java.util.Date;
import java.util.List;

/**
 *  url_request_token
 * @author 大狼狗 2019-04-28
 */
@Data
public class UrlRequestToken implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 请求id
     */
    @TableId
    private String requestId;

    /**
     * TOKEN请求地址
     */
    private String tokenUrl;

    /**
     * 请求方式
     */
    private String method;

    /**
     * 请求参数
     */
    private String param;
    /**
     * 参数方式：1form表单 2json格式/xml
     */
    private String paramType;

    /**
     * 追加方式：1通过url追加 2通过form追加
     */
    private String appendType;

    /**
     * 追加参数key名
     */
    private String appendName;

    /**
     * TOKEN表达式
     */
    private String tokenExpression;

    /**
     * 是否启动：1启用 0禁用
     */
    private Integer status;

    public UrlRequestToken() {
    }
    @Data
    public static class Method{
        public static String GET="GET";
        public static String POST="POST";
    }
    @Data
    public static class ParamType{
        public static String FORM="FORM";
        public static String JSON="JSON";
    }
    @Data
    public static class AppendType{
        public static String URL="URL";
        public static String FORM="FORM";
    }
}