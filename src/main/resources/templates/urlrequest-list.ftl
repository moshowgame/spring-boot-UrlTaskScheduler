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
    <!-- 弹出层 -->
    <el-dialog title="TASK定时任务" :visible.sync="dialogFormVisible">
        <el-form :model="formData">
            <el-form-item label="任务ID" :label-width="formLabelWidth">
                <el-input v-model="formData.requestId" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="任务名称" :label-width="formLabelWidth">
                <el-input v-model="formData.requestName" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="请求方式" :label-width="formLabelWidth">
                <el-select v-model="formData.requestMethod" placeholder="请选择请求方式">
                    <el-option label="POST" value="POST"></el-option>
                    <el-option label="GET" value="GET"></el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="CRON表达式" :label-width="formLabelWidth">
                <el-input v-model="formData.requestCron" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="请求URL" :label-width="formLabelWidth">
                <el-input v-model="formData.requestUrl" autocomplete="off"></el-input>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="dialogFormVisible = false">取 消</el-button>
            <el-button type="primary"  @click="submitForm('formData')">确 定</el-button>
        </div>
    </el-dialog>
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
                width="100">
        </el-table-column>
        <el-table-column
                prop="requestName"
                label="任务名称"
                width="200">
        </el-table-column>
        <el-table-column
                prop="requestUrl"
                label="请求URL"
                :show-overflow-tooltip="true"
                width="200">
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
                width="80">
        </el-table-column>

        <el-table-column label="操作">
            <template slot-scope="scope">
                <el-button
                        size="mini"
                        type="info"
                        @click="handleEdit(scope.$index,scope.row)">修改
                </el-button>
                <el-button
                        size="mini"
                        type="primary"
                        @click="handleStart(scope.$index, scope.row)">启动
                </el-button>
                <el-button
                        size="mini"
                        type="warning"
                        @click="handleStop(scope.$index, scope.row)">暂停
                </el-button>
                <el-button
                        size="mini"
                        type="success"
                        @click="handleContinue(scope.$index, scope.row)">继续
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
                dialogFormVisible: false,
                formLabelWidth: '120px',
                formData:{
                    "requestId":"",
                    "requestName":"",
                    "requestCron":"",
                    "requestMethod":"",
                    "requestUrl":"",
                },
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
                }).catch(function (error) {
                        console.log(error);
                    });
            },
            formatterStatus: function (val) {
                switch(val.status){
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
                    //action
                    this.$http.post('${request.contextPath}/urlTask/start',column,{emulateJSON:true}).then(function(res){
                        if(res.body.code==0){
                            this.$confirm(res.body.msg);
                            //登录成功跳转
                        }else{
                            this.$confirm(res.body.msg);
                        }
                    },function(){
                        this.$message({
                            type: 'error',
                            message: '启动失败^_^'
                        });
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '取消启动=.='
                    });
                });
            },
            handleContinue(row, column) {
                this.$confirm('此操作将继续执行任务, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    //action
                    this.$http.post('${request.contextPath}/urlTask/continue',column,{emulateJSON:true}).then(function(res){
                        if(res.body.code==0){
                            this.$confirm(res.body.msg);
                            //登录成功跳转
                        }else{
                            this.$confirm(res.body.msg);
                        }
                    },function(){
                        this.$message({
                            type: 'error',
                            message: '继续任务失败^_^'
                        });
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '取消操作=.='
                    });
                });
            },
            handleStop(row, column) {
                this.$confirm('此操作将停止任务, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    //action
                    this.$http.post('${request.contextPath}/urlTask/stop',column,{emulateJSON:true}).then(function(res){
                        if(res.body.code==0){
                            this.$confirm(res.body.msg);
                            //登录成功跳转
                        }else{
                            this.$confirm(res.body.msg);
                        }
                    },function(){
                        this.$message({
                            type: 'error',
                            message: '停用失败^_^'
                        });
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '取消操作=.='
                    });
                });
            },
            handleEdit(row, column) {
                console.log(column);
                this.dialogFormVisible = true;
                this.formData=column;
            },
            handleDelete(row, column) {
                this.$confirm('此操作将停止并删除任务, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    //action
                    this.$http.post('${request.contextPath}/urlTask/delete',column,{emulateJSON:true}).then(function(res){
                        if(res.body.code==0){
                            this.$confirm(res.body.msg);
                            //登录成功跳转
                        }else{
                            this.$confirm(res.body.msg);
                        }
                    },function(){
                        this.$message({
                            type: 'error',
                            message: '删除失败^_^'
                        });
                    });

                }).catch((e) => {
                    this.$message({
                        type: 'info',
                        message: '取消操作=.='+e.toString()
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
            submitForm:function(formName) {
                //发送get请求
                this.$http.post('${request.contextPath}/urlTask/save',this.formData,{emulateJSON:false}).then(function(res){
                    if(res.body.code==0){
                        this.$confirm(res.body.msg);
                        //登录成功跳转
                    }else{
                        this.$confirm(res.body.msg);
                    }
                    this.dialogFormVisible = false;
                    this.formData = {
                            "requestId":"",
                            "requestName":"",
                            "requestCron":"",
                            "requestMethod":"",
                            "requestUrl":"",
                    };
                },function(){
                    console.log('请求失败处理');
                });

            }
        }
    }
    var Ctor = Vue.extend(Main)
    new Ctor().$mount('#app')
</script>
</html>