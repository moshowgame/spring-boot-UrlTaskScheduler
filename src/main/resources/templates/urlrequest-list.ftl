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
            :data="tableData"
            tooltip-effect="dark"
            style="width: 100%"
            @selection-change="handleSelectionChange">
        <el-table-column
                type="selection"
                width="55">
        </el-table-column>
        <el-table-column
                prop="requestId"
                label="任务ID"
                width="120">
        </el-table-column>
        <el-table-column
                prop="requestName"
                label="任务名称"
                width="240">
        </el-table-column>
        <el-table-column
                prop="requestCron"
                label="执行时间表达式"
                width="120">
        </el-table-column>
        <el-table-column
                prop="status"
                :formatter="formatterStatus"
                label="任务状态"
                width="120">
        </el-table-column>

        <el-table-column label="操作">
            <template slot-scope="scope">
                <el-button
                        size="mini"
                        type="info"
                        @click="handleEdit(scope.$index, scope.row)">修改
                </el-button>
                <el-button
                        size="mini"
                        type="primary"
                        @click="handleStart(scope.$index, scope.row)">启动
                </el-button>
                <el-button
                        size="mini"
                        type="warning"
                        @click="handleEdit(scope.$index, scope.row)">暂停
                </el-button>
                <el-button
                        size="mini"
                        type="success"
                        @click="handleEdit(scope.$index, scope.row)">继续
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
                :total="total" :page-size="pageSize"
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
                    "requestCron": "0/10 * * * * ? ",
                    "requestId": "1",
                    "requestName": "localhost",
                    "requestId": "DEFAULT",
                    "status": "ACQUIRED"
                }],
                multipleSelection: [],
                total: 1,
                pageSize:3,
                pageNo:1
            }
        },
        created: function(){
            // 组件创建完后获取数据，
            // 此时 data 已经被 observed 了
            this.fetchData();
        },
        methods: {
            fetchData: function () {
                this.$http({
                    method: 'POST',
                    url: '${request.contextPath}/urlTask/list',
                    params:{pageNo:this.pageNo,pageSize:this.pageSize}
                }).then(res => {
                    console.log(res);
                    this.tableData = res.data.msg;
                    this.total= res.data.total;
                    this.pageNo=res.data.pageNo;
                    this.pageSize=res.data.pageSize;
                })
                    .catch(function (error) {
                        console.log(error);
                    });
            },
            formatterStatus: function (row, column) {
                switch(row.status){
                    case 0:
                        return '停止';
                        break;
                    case 1:
                        return '启动';
                        break;
                    case  2:
                        return '禁用';
                        break;
                    case 3:
                        return '暂停';
                        break;
                    default:
                        return '未知';
                }
                // return row.sex === 1 ? '男' : row.sex === 0 ? '女' : '未知'
            },
            handleStart(row, column) {
                this.$confirm('此操作将启动任务, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.$message({
                        type: 'success',
                        message: '启动成功^_^'
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '取消启动=.='
                    });
                });
            },
            handleSelectionChange:function(){
            },
            current_change:function(pageNo){
                this.pageNo = pageNo;
                this.tableData=[];
                this.fetchData();
                console.log("current_change:"+this.tableData);
            },
            /*mounted: function () {
                this.getData();
            },*/
            handleEdit:function(){
            },
            handleDelete:function(){
            },
        }
    }
    var Ctor = Vue.extend(Main)
    new Ctor().$mount('#app')
</script>
</html>