package com.software.dev.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.software.dev.domain.SysToken;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @author mosho
 */
@Mapper
public interface SysTokenMapper  extends BaseMapper<SysToken> {

}
