package com.software.dev.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class PageParam implements Serializable {

    Boolean _search;
    String nd;
    Integer limit;
    Integer page;
    Integer sidx;
    String order;
    String search;
    String id;

}
