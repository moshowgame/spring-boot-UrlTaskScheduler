package com.software.dev.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;

@Data
public class UrlResponseAssumption implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 请求id
     */
    @TableId
    private String requestId;

    String keyFirst;
    String valueFirst;
    String keySecond;
    String valueSecond;
    String keyThird;
    String valueThird;
    String valueElse;

}
