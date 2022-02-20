<template>
    <div class="empty-container">
        <page-header title="欢迎使用 spring-boot-UrlTaskScheduler 2022" class="header">
            <template #content>
                <div>
                    <div style="margin-bottom: 5px;">以前叫EasyUrlTask,现在正式改为UrlTaskScheduler,基于BackEnd:Quartz 2.3+SpringBoot2,Frontend:vue one-step-admin 的<b class="text-emphasis">URL接口调度平台</b>,支持集群.日常的很多任务调度其实都可以简化为基于URL的调度方式,UrlTaskScheduler也就因此而生,<b>让URL调度任务更方便</b>。</div>
                    <el-button-group style="margin-right: 10px;">
                        <el-button type="success" size="large" plain @click="open(`https://zhengkai.blog.csdn.net`)">
                            <svg-icon name="ri-file-text-line" />
                            CSDN技术博客
                        </el-button>
                        <el-button type="primary" size="large" @click="open(`https://github.com/moshowgame/spring-boot-UrlTaskScheduler`)">
                            <svg-icon name="ri-code-s-slash-line" />
                            Github代码仓库
                        </el-button>
                    </el-button-group>
                </div>
            </template>
        </page-header>
    </div>
</template>

<script setup>

function open(url) {
    window.open(url, 'top')
}
</script>

<style lang="scss" scoped>
.empty-container {
    height: 100%;
    overflow: auto;
    .header {
        margin: 0;
        .text-emphasis {
            /* stylelint-disable-next-line property-no-vendor-prefix */
            -webkit-text-emphasis-style: "❤";
        }
        a {
            color: inherit;
            text-decoration: none;
            border-bottom: 1px solid #ccc;
            cursor: pointer;
        }
    }
}
</style>
