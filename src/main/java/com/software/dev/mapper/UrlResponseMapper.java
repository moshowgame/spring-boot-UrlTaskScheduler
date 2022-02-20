package com.software.dev.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.software.dev.domain.UrlRequest;
import com.software.dev.domain.UrlResponse;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 *  url_response
 * @author 大狼狗 2019-03-15
 */
@Mapper
public interface UrlResponseMapper extends BaseMapper<UrlResponse> {



}