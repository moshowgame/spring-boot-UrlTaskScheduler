<template>
    <div>
        <page-header title="什么是Response List？" content="当URL任务执行的时候，就会生成一条响应，用于记录该次请求返回的结果，也可以理解为Request Log。" />
        <page-main>
<!--            <el-button type="primary" icon="el-icon-plus">新增</el-button>-->
            <search-bar>
                <el-form :model="search" size="small" label-width="100px" label-suffix="：">
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="选择请求">
                                <el-select v-model="search.requestId" class="m-2" placeholder="Select">
                                    <el-option
                                        v-for="item in search.responseIdOptions"
                                        :key="item.requestId"
                                        :label="item.requestName"
                                        :value="item.requestId"
                                    >
                                    </el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item label="报文内容">
                                <el-input v-model="search.responseText" placeholder="请输入报文内容，支持模糊查询" clearable @keydown.enter="getDataList" @clear="getDataList" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-form-item>
                        <el-button type="primary" icon="el-icon-search" @click="getDataList">筛 选</el-button>
                    </el-form-item>
                </el-form>
            </search-bar>
            <el-pagination v-model:current-page="page.currentPage" layout="total, sizes, prev, pager, next, jumper" class="pagination"
                           :page-size="page.pageSize" :page-sizes="[5,20,50,100]" :total="page.total" :pager-count="5" background
                           @size-change="getDataList"
                           @current-change="getDataList"
            />
            <el-table ref="table" class="list-table" :data="dataList" border stripe highlight-current-row>
                <el-table-column prop="responseId" label="请求ID" />
                <el-table-column prop="requestId" label="请求名称" />
                <el-table-column prop="requestTime" label="请求时间" />
                <el-table-column prop="responseTime" label="响应时间" />
                <el-table-column prop="responseText" label="响应报文" />
                <el-table-column prop="status" label="状态">
                    <template #default="scope">
                        <el-tag type="error" v-if="scope.row.status===0" disable-transitions >失败 </el-tag>
                        <el-tag type="success" v-if="scope.row.status===1" disable-transitions >成功 </el-tag>
                        <el-tag type="warning" v-if="scope.row.status===9" disable-transitions >异常 </el-tag>
                        <el-tag type="warning" v-if="scope.row.status===null" disable-transitions >未知 </el-tag>
                    </template>
                </el-table-column>
                <el-table-column prop="assumptionResult" label="推断结果" />
            </el-table>
        </page-main>
    </div>
</template>

<script>
export default {
    methods: {
        getRequestDropdown() {
            const that = this;
            this.$api.post('urlTask/request/list2', {
                search: this.search.responseText
            }).then(res=>{
                // 后续业务代码
                // console.log(res)
                that.search.responseIdOptions = res.data
                that.search.requestId = res.data[0].requestId
            })
        },
        getDataList() {
            const that = this;
            this.$message.success({
                message: '获取数据中',
                center: true
            })
            this.$api.post('urlTask/response/list', {
                page: this.page.currentPage,
                limit: this.page.pageSize,
                requestId: that.search.requestId,
                search: that.search.responseText
            }).then(res=>{
                // 后续业务代码
                console.log(res)
                that.dataList = res.page.list
                that.page.total = res.page.totalCount
            })
        },
        handleSizeChange(val){
            console.log(`${val} items per page`)
            this.page.pageSize = val
            this.getDataList()
        },
        handleCurrentChange(val){
            console.log(`current page: ${val}`)
            this.page.currentPage = val
            this.getDataList()
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
    },
    data() {
        return {
            // 搜索
            search: {
                requestName: '',
                requestId: '',
                responseIdOptions: [{requestId:10004,requestName:'请求'}],
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
            page: {
                currentPage:1,
                pageSize:5,
                total:100
            }

        }
    },
    mounted() {
        console.log('mounted')
        this.getRequestDropdown();
        this.getDataList();
    },
}
</script>

<style lang="scss" scoped>
.el-pagination {
    margin-top: 20px;
}
</style>
