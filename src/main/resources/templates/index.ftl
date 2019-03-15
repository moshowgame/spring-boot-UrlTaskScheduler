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
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
        <el-form-item>
            <src img="https://developers.weixin.qq.com/miniprogram/introduction/image/a.png?t=19031222">
        </el-form-item>
        <el-form-item label="账号">
            <el-input v-model="ruleForm.username"></el-input>
        </el-form-item>
        <el-form-item label="密码">
            <el-input v-model="ruleForm.password"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="submitForm('ruleForm')">登录</el-button>
            <el-button @click="resetForm('ruleForm')">重置</el-button>
        </el-form-item>
    </el-form>
</div>
</body>
<@common.commonScript />
<script>
    var Main = {
        data() {
            return {
                ruleForm: {
                    username: '',
                    password: ''
                },
                rules: {
                    username: [
                        { required: true, message: '请输入账号', trigger: 'change' },
                        { min: 6, max: 25, message: '长度在 6 到 25 个字符', trigger: 'blur' }
                    ],
                    password: [
                        { required: true, message: '请输入密码', trigger: 'change' },
                        { min: 6, max: 25, message: '长度在 6 到 25 个字符', trigger: 'blur' }
                    ]
                }
            };
        },
        methods: {
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        //发送get请求
                        this.$http.post('${request.contextPath}/login',{username:"菜鸟教程",password:"http://www.runoob.com"},{emulateJSON:true}).then(function(res){
                            if(res.body.code==0){
                                this.$confirm(res.body.msg);
                                //登录成功跳转
                            }else{
                                this.$confirm(res.body.msg);
                            }
                        },function(){
                            console.log('请求失败处理');
                        });
                    } else {
                        console.log('验证不通过处理');
                        return false;
                    }
                });
            },
            resetForm(formName) {
                this.$refs[formName].resetFields();
            }
        }
    }
    var Ctor = Vue.extend(Main)
    new Ctor().$mount('#app')
</script>
</html>