package com.software.dev.domain;

import lombok.Data;

/**
 * @author zhengkai
 */
@Data
public class QuartzEntity {
    private String jobName;
    private String jobGroup;
    private String description;
    private String jobClassName;
    private String cronExpression;
    private String triggerName;
    private String triggerState;
    private String oldJobName;
    private String oldJobGroup;
}
