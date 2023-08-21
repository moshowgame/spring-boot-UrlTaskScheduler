package com.software.dev.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.software.dev.domain.UrlRequest;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
public interface UrlRequestMapper extends BaseMapper<UrlRequest> {

    @Select("<script>"
            +" select t.*,tri.TRIGGER_STATE,tri.NEXT_FIRE_TIME from url_request t "
            +" left join qrtz_triggers tri on t.request_id=tri.JOB_NAME  where 1=1 "
            + "<if test='search!=null'> and (t.request_name LIKE CONCAT('%',#{search},'%') or t.request_group LIKE CONCAT('%',#{search},'%') )</if>"
            + " order by t.request_id desc "
            + "<if test='pageStart!=null and pageSize != null '> LIMIT  #{pageStart},#{pageSize} </if></script>")
    List<UrlRequest> listUrl(Integer pageStart,Integer pageSize,String search);

}
