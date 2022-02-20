<template>
    <el-tabs ref="tabs" v-model="activeName" class="notification">
        <el-tab-pane label="通知 (5)" name="notice" class="container">
            <div class="list">
                <div class="item">
                    <i class="ri-mail-fill" />
                    <div class="info">
                        <div class="title">你收到了 8 份日报</div>
                        <div class="date">2020-10-10 10:00:00</div>
                    </div>
                </div>
                <div class="item">
                    <i class="ri-service-fill" />
                    <div class="info">
                        <div class="title">你收到了 3 位同事的好友申请，请及时处理</div>
                        <div class="date">2020-10-10 10:00:00</div>
                    </div>
                </div>
                <div class="item">
                    <i class="ri-file-edit-fill" />
                    <div class="info">
                        <div class="title">你有 3 份合同待审批</div>
                        <div class="date">2020-10-10 10:00:00</div>
                    </div>
                </div>
                <div class="item">
                    <i class="ri-mail-fill" />
                    <div class="info">
                        <div class="title">你收到了 8 份日报</div>
                        <div class="date">2020-10-10 10:00:00</div>
                    </div>
                </div>
                <div class="item">
                    <i class="ri-service-fill" />
                    <div class="info">
                        <div class="title">你收到了 3 位同事的好友申请，请及时处理</div>
                        <div class="date">2020-10-10 10:00:00</div>
                    </div>
                </div>
            </div>
            <div class="more">进入通知列表</div>
        </el-tab-pane>
        <el-tab-pane label="消息" name="message" class="container">
            <div class="list">
                <div class="empty">你已读完所有消息</div>
            </div>
        </el-tab-pane>
        <el-tab-pane label="待办 (2)" name="todo" class="container">
            <div class="list">
                <div class="item">
                    <i class="ri-bug-fill" />
                    <div class="info">
                        <div class="title">你有 2 个来自项目「Fantastic-admin」的 bug 待处理</div>
                        <div class="date">2020-10-10 10:00:00</div>
                    </div>
                </div>
                <div class="item">
                    <i class="ri-git-merge-fill" />
                    <div class="info">
                        <div class="title">你有 3 个来自项目「Fantastic-admin」的代码合并申请，提交人：Hooray，提交备注：专业版更新</div>
                        <div class="date">2020-10-10 10:00:00</div>
                    </div>
                </div>
            </div>
        </el-tab-pane>
    </el-tabs>
</template>

<script setup name="Notification">
const activeName = ref('notice')
</script>

<style lang="scss" scoped>
.notification {
    margin-top: -10px;
    :deep(.el-tabs__header) {
        margin-bottom: 0;
    }
    :deep(.el-tabs__nav-scroll) {
        text-align: center;
        .el-tabs__nav {
            display: inline-block;
            margin: 0 auto;
            float: none;
            .el-tabs__item {
                padding: 0 12px;
            }
        }
    }
}
.container {
    .list {
        max-height: 300px;
        overflow-y: auto;
        overscroll-behavior: contain;
        .item {
            display: flex;
            align-items: flex-start;
            padding: 15px 10px;
            transition: 0.3s;
            border-bottom: 1px solid #eee;
            cursor: pointer;
            &:hover {
                background-color: #e6f7ff;
            }
            &:last-child {
                border-bottom: unset;
            }
            i {
                margin-right: 10px;
                padding: 10px;
                border-radius: 50%;
                color: #fff;
                background-color: #3391e5;
                &.ri-service-fill {
                    background-color: #fe5d58;
                }
                &.ri-file-edit-fill {
                    background-color: #dab033;
                }
                &.ri-bug-fill {
                    background-color: #f56c6c;
                }
            }
            .info {
                .title {
                    font-size: 14px;
                    line-height: 1.5;
                    @include text-overflow(2);
                }
                .date {
                    margin-top: 5px;
                    font-size: 12px;
                    color: #999;
                }
            }
        }
        .empty {
            padding: 30px 0;
            text-align: center;
            color: #999;
        }
    }
    .more {
        padding: 15px 0;
        margin-bottom: -10px;
        text-align: center;
        color: #666;
        border-top: 1px solid #eee;
        cursor: pointer;
    }
}
</style>
