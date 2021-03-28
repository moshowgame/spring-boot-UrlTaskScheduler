package com.software.dev.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class SysToken {
    /**
     * 请求id
     */
    @TableId(type = IdType.AUTO)
    Integer tokenId;

    String tokenValue;
}
