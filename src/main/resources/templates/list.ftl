<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SpringBoot EasyUrlTask</title>
    <#import "common/common-import.ftl" as common>
    <@common.commonStyle />

</head>
<body>
<div id="app">
    <!-- 分页 -->
    <el-table
            ref="multipleTable"
            :data="tableData.slice((currentPage-1)*pageSize,currentPage*pageSize)"
            tooltip-effect="dark"
            style="width: 100%"
            @selection-change="handleSelectionChange">
        <el-table-column
                type="selection"
                width="55">
        </el-table-column>
        <el-table-column
                prop="jobName"
                label="任务名称"
                width="120">
        </el-table-column>
        <el-table-column
                prop="cronExpression"
                label="任务表达式"
                width="120">
        </el-table-column>
        <el-table-column
                prop="triggerState"
                label="任务状态"
                width="120">
        </el-table-column>

        <el-table-column label="操作">
            <template slot-scope="scope">
                <el-button
                        size="mini"
                        @click="handleEdit(scope.$index, scope.row)">修改
                </el-button>
                <el-button
                        size="mini"
                        type="danger"
                        @click="handleDelete(scope.$index, scope.row)">删除
                </el-button>
            </template>
        </el-table-column>
    </el-table>
    <div style="text-align: center;margin-top: 30px;">
        <el-pagination
                background
                layout="prev, pager, next"
                :total="total"
                @current-change="current_change">
        </el-pagination>
    </div>
</div>
</body>
<@common.commonScript />
<script>
    var Main = {
        data() {
            return {
                tableData: [{
                    "cronExpression": "0/10 * * * * ? ",
                    "jobClassName": "com.software.dev.job.UrlJob",
                    "jobGroup": "DEFAULT",
                    "jobName": "localhost",
                    "oldJobGroup": "DEFAULT",
                    "oldJobName": "localhost",
                    "triggerName": "triggerlocalhost",
                    "triggerState": "ACQUIRED"
                }],
                multipleSelection: [],
                total: 1,
                pageSize:10,
                currentPage:1
            }
        },
        created: function(){
            // 组件创建完后获取数据，
            // 此时 data 已经被 observed 了
            this.fetchData();
        },
        methods: {
            fetchData() {
                this.$http({
                    method: 'POST',
                    url: '${request.contextPath}/oldJob/list',
                }).then(res => {
                    console.log(res);
                    this.tableData = res.data.msg;
                    this.total= res.data.total;
                })
                    .catch(function (error) {
                        console.log(error);
                    });
            },
            handleSelectionChange:function(){
                done();
            },
            current_change:function(currentPage){
                this.currentPage = currentPage;
            },
            mounted: function () {
                this.getData();
            },
            handleEdit:function(){
                done();
            },
            handleDelete:function(){
                done();
            },
        }
    }
    var Ctor = Vue.extend(Main)
    new Ctor().$mount('#app')
</script>
</html>