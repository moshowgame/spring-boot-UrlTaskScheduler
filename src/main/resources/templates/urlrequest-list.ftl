<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SpringBoot EasyUrlTask</title>
    <#import "common/common-import.ftl" as common>
    <@common.commonStyle />

</head>
<body>

<el-container>

    <el-container>
        <el-header>
            <#--<el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>EasyTask</el-breadcrumb-item>
                <el-breadcrumb-item>任务管理</el-breadcrumb-item>
                <el-breadcrumb-item>任务列表</el-breadcrumb-item>
            </el-breadcrumb>-->
        </el-header>
        <el-main>
            <#--内容展示-->
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
                        width=" 99.9%"
                        @selection-change="handleSelectionChange">
                    <el-table-column
                            type="selection"
                            width="50">
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
                        <template slot-scope="scope">
                            <el-popover trigger="hover" placement="top">
                                <p>任务名称: {{ scope.row.requestName }}</p>
                                <p>请求方式: {{ scope.row.requestMethod }}</p>
                                <p>请求URL: {{ scope.row.requestUrl }}</p>
                                <p>下次执行: {{ scope.row.nextFireTime }}</p>
                                <div slot="reference" class="name-wrapper">
                                    <el-tag size="medium">{{ scope.row.requestName }}</el-tag>
                                </div>
                            </el-popover>
                        </template>
                    </el-table-column>
                    <el-table-column
                            prop="requestUrl"
                            label="请求URL"
                            :show-overflow-tooltip="true"
                            >
                    </el-table-column>
                    <el-table-column
                            label="计划时间"
                            >
                        <template slot-scope="scope">
                            <i class="el-icon-time"></i>
                            <span style="margin-left: 1px">{{ scope.row.requestCron }}</span>
                        </template>
                    </el-table-column>
                    <el-table-column
                            prop="status"
                            <#--:formatter="formatterStatus"-->
                            label="任务状态"
                            >
                        <template slot-scope="scope">
                            <el-popover trigger="hover" placement="top">
                                <p>任务状态: {{ formatterStatus(scope.row.status) }}</p>
                                <p>Quartz状态: {{ scope.row.triggerState }}</p>
                                <div slot="reference" class="name-wrapper">
                                    <el-tag
                                            :type="scope.row.status == '1' ? 'success' : 'danger'"
                                            disable-transitions>{{ formatterStatus(scope.row.status) }}</el-tag>
                                </div>
                            </el-popover>
                        </template>
                    </el-table-column>
                    <el-table-column label="操作">
                        <template slot="header" slot-scope="scope">
                            <el-input
                                    v-model="search"
                                    size="mini"  @change="search_change()"
                                    placeholder="输入关键字搜索"/>
                            <i
                                    class="el-icon-search el-input__icon"
                                    slot="suffix">
                            </i>
                        </template>
                        <template slot-scope="scope">
                            <el-dropdown>
                                  <span class="el-dropdown-link">
                                      <el-button plain>
                                        任务操作<i class="el-icon-arrow-down el-icon--right"></i>
                                      </el-button>
                                  </span>
                                <el-dropdown-menu slot="dropdown">
                                    <el-dropdown-item>
                                        <el-button
                                                size="mini"
                                                type="success"
                                                @click="handleLog(scope.$index,scope.row)">查看日志
                                        </el-button>
                                    </el-dropdown-item>
                                    <el-dropdown-item>
                                        <el-button
                                                size="mini"
                                                type="info"
                                                @click="handleCopy(scope.$index,scope.row)">复制
                                        </el-button>
                                    </el-dropdown-item>
                                    <el-dropdown-item>
                                        <el-button
                                                size="mini"
                                                type="info"
                                                @click="handleEdit(scope.$index,scope.row)">修改
                                        </el-button>
                                    </el-dropdown-item>
                                    <el-dropdown-item>
                                        <el-button
                                                size="mini"
                                                type="primary"
                                                @click="handleStart(scope.$index, scope.row)">启动
                                        </el-button>
                                    </el-dropdown-item>
                                    <el-dropdown-item>
                                        <el-button
                                                size="mini"
                                                type="warning"
                                                @click="handleStop(scope.$index, scope.row)">停止
                                        </el-button>
                                    </el-dropdown-item>
                                    <el-dropdown-item>
                                        <el-button
                                                size="mini"
                                                type="success"
                                                @click="handleTrigger(scope.$index, scope.row)">触发一次
                                        </el-button>
                                    </el-dropdown-item>
                                    <el-dropdown-item>
                                        <el-button
                                                size="mini"
                                                type="danger"
                                                @click="handleDelete(scope.$index, scope.row)">删除
                                        </el-button>
                                    </el-dropdown-item>
                                </el-dropdown-menu>
                            </el-dropdown>

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
        </el-main>
    </el-container>
</el-container>


</body>
<@common.commonScript />
<style>
    .el-header {
        background-color: #B3C0D1;
        color: #333;
        line-height: 60px;
    }

    .el-aside {
        color: #333;
    }
</style>

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
                search:"",
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
                    params:{pageNo:this.pageNo,pageSize:this.pageSize,search:this.search}
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
                switch(val){//.status
                    case 0:
                        return '停止';
                        break;
                    case 1:
                        return '启用';
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
                            //操作成功则刷新
                            this.current_change(this.pageNo);
                        }else{
                            this.$message({type: 'error',message: res.body.msg});
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
            handleTrigger(row, column) {
                this.$confirm('此操作将单独触发一次任务, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    //action
                    this.$http.post('${request.contextPath}/urlTask/trigger',column,{emulateJSON:true}).then(function(res){
                        if(res.body.code==0){
                        }else{
                            this.$message({type: 'error',message: res.body.msg});
                        }
                    },function(){
                        this.$message({
                            type: 'error',
                            message: '触发失败^_^'
                        });
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '取消触发=.='
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
                    this.$http.post('${request.contextPath}/urlTask/pause',column,{emulateJSON:true}).then(function(res){
                        if(res.body.code==0){
                            //操作成功则刷新
                            this.current_change(this.pageNo);
                        }else{
                            this.$message({type: 'error',message: res.body.msg});
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
            handleCopy(row, column) {
                this.dialogFormVisible = true;
                //this.formData=column会导致修改表单的值，表格的值也会变，格式化一下即可解决这个问题
                this.formData= JSON.parse(JSON.stringify(column)) ;
                this.formData.requestId=column.requestId+"COPY";
            },
            handleLog(row, column) {
                window.open ('${request.contextPath}/log/page?requestId='+column.requestId, '日志查看', 'height=400, width=800, top=0,left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no')
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
                            //操作成功则刷新
                            this.current_change(this.pageNo);
                        }else{
                            this.$message({type: 'error',message: res.body.msg});
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
            },
            search_change:function(){
                this.tableData=[];
                this.fetchData();
            },
            submitForm:function(formName) {
                //发送get请求
                this.$http.post('${request.contextPath}/urlTask/save',this.formData,{emulateJSON:false}).then(function(res){
                    if(res.body.code==0){
                        this.$confirm(res.body.msg);
                        //操作成功则刷新
                        this.current_change(this.pageNo);
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