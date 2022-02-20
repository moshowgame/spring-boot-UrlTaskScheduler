<template>
    <div>
        <page-header title="什么是Request Task？" content="这是最重要的部分，一个任务从请求开始，在这里定义你的请求详情吧（例如请求什么url，定时的方式是什么）。" />
        <page-main>
            <el-button type="primary" icon="el-icon-plus">新增</el-button>
            <search-bar>
                <el-form :model="search" size="small" label-width="100px" label-suffix="：">
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="请求名称">
                                <el-input v-model="search.requestName" placeholder="请输入请求名称，支持模糊查询" clearable @keydown.enter="getDataList" @clear="getDataList" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-form-item>
                        <el-button type="primary" icon="el-icon-search" @click="getDataList">筛 选</el-button>
                    </el-form-item>
                </el-form>
            </search-bar>
            <el-table ref="table" class="list-table" :data="dataList" border stripe highlight-current-row>
                <el-table-column prop="requestId" label="请求ID" />
                <el-table-column prop="requestName" label="请求名称" />
                <el-table-column prop="requestMethod" label="请求方式" />
                <el-table-column prop="requestCron" label="CRON表达式" />
                <el-table-column prop="requestUrl" label="请求URL" />
                <el-table-column prop="status" label="任务状态" >
                    <template #default="scope">
                        <el-tag type="success" v-if="scope.row.status===1" disable-transitions >启用 </el-tag>
                        <el-tag type="danger" v-if="scope.row.status===0" disable-transitions >禁用 </el-tag>
                        <el-tag type="warning" v-if="scope.row.status===null" disable-transitions >未知 </el-tag>
                    </template>
                </el-table-column>
                <el-table-column prop="triggerState" label="触发状态">
                    <template #default="scope">
                        <el-tag type="success" v-if="scope.row.triggerState==='WAITING'" disable-transitions >等待中 </el-tag>
                        <el-tag type="warning" v-if="scope.row.triggerState==='PAUSED'" disable-transitions >任务暂停 </el-tag>
                        <el-tag type="info" v-if="scope.row.triggerState==='ACQUIRED'" disable-transitions >正在执行中 </el-tag>
                        <el-tag type="danger" v-if="scope.row.triggerState==='BLOCKED'" disable-transitions >任务阻塞 </el-tag>
                        <el-tag type="danger" v-if="scope.row.triggerState==='ERROR'" disable-transitions >任务错误 </el-tag>
                        <el-tag type="warning" v-if="scope.row.triggerState===null" disable-transitions >未知 </el-tag>
                    </template>
                </el-table-column>
                <el-table-column prop="nextFireTime" label="下次执行" />
                <el-table-column label="更新时间" :formatter="dateFormat"/>
                <el-table-column label="操作" width="200" align="center">
                    <template #default="scope">
                        <el-button type="primary" size="small" plain @click="start(scope.row)">启用</el-button>
                        <el-button type="primary" size="small" plain @click="pause(scope.row)">暂停</el-button>
                        <el-button type="primary" size="small" plain @click="trigger(scope.row)">执行</el-button>
                        <el-button type="primary" size="small" plain @click="onEdit(scope.row)">编辑</el-button>
                        <el-button type="danger" size="small" plain @click="onDel(scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-pagination :current-page="page" :total="100" :page-size="10" :page-sizes="[10, 50, 100]" layout="total, sizes, ->, prev, pager, next, jumper" :hide-on-single-page="false" class="pagination" background />
        </page-main>
    </div>
</template>

<script>
export default {
    data() {
        return {
            // 搜索
            search: {
                requestName: ''
            },
            // 列表数据
            dataList: [{
                "requestId": 99999,
                "requestName": "DEMO REQUEST",
                "requestCron": "0 0/30 * * * ? *",
                "requestUrl": "http://localhost:6969/quartz/demo/request",
                "requestMethod": "POST",
                "status": 0,
                "requestTimeout": null,
                "updateTime": "2020-10-01 23:30:00",
                "triggerState": null,
                "nextFireTime": null
            }],
            page: 3

        }
    },
    methods: {
        getDataList() {
            const that = this;
            this.$message.success({
                message: '你点击了筛选',
                center: true
            })
            this.$api.post('urlTask/request/list', {
                page: 1,
                limit: 10,
                search: that.search.requestName
            }).then(res=>{
                // 后续业务代码
                console.log(res)
                that.dataList = res.page.list
            })
        },
        onCreate() {
            this.$message.success({
                message: '你点击了新增',
                center: true
            })
        },
        onEdit(row) {
            this.$message.success({
                message: `你点击了编辑,「${row.requestId} - ${row.requestName}」`,
                center: true
            })
        },
        start(row) {
            this.$message.success({
                message: `启动 「${row.requestId} - ${row.requestName}」`,
                center: true
            })
            const that = this;
            this.$api.post('urlTask/request/start', "requestId="+row.requestId).then(res=>{
                that.getDataList()
            })
        },
        open(row) {
            this.$message.success({
                message: `启用 「${row.requestId} - ${row.requestName}」`,
                center: true
            })
        },
        pause(row) {
            this.$message.success({
                message: `暂停 「${row.requestId} - ${row.requestName}」`,
                center: true
            })
            const that = this;
            this.$api.post('urlTask/request/pause', "requestId="+row.requestId).then(res=>{
                that.getDataList()
            })
        },
        trigger(row) {
            this.$message.success({
                message: `执行 「${row.requestId} - ${row.requestName}」`,
                center: true
            })
            const that = this;
            this.$api.post('urlTask/request/trigger', "requestId="+row.requestId).then(res=>{
                that.getDataList()
            })
        },
        onDel(row) {
            this.$confirm(`删除「${row.requestId} - ${row.requestName}」吗？`, '确认信息').then(() => {
                this.$message.success({
                    message: '你点击了删除',
                    center: true
                })
                const that = this;
                this.$api.post('urlTask/request/delete', "requestId="+row.requestId).then(res=>{
                    that.getDataList()
                })
            }).catch(() => {})
        },
        dateFormat(row, column){
            //blog.csdn.net/moshowgame
            const date = new Date(parseInt(row.nextFireTime));
            console.log(date)
            const Y = date.getFullYear() + '-';
            const M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
            const D = (date.getDate()<10?'0'+date.getDate():date.getDate()) + ' ';
            const h = (date.getHours() <10?'0'+date.getHours() :date.getHours() )+ ':';
            const m = (date.getMinutes() <10?'0'+date.getMinutes() :date.getMinutes() ) + ':';
            const s = (date.getSeconds() <10?'0'+date.getSeconds() :date.getSeconds() );

            return date;
        }
    }
}
</script>

<style lang="scss" scoped>
.el-pagination {
    margin-top: 20px;
}
</style>
