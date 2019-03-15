new Vue({
el: '#app',
data: function() {
dataForm: {
username: '',
token: ''
},
rules: {
username: [
{ required: true, message: '请输入用户名称', trigger: 'change' },
{ min: 4, max: 20, message: '长度在 4 到 20 个字符', trigger: 'blur' }
],
token: [
{ required: true, message: '请选择密码', trigger: 'change' },
{ min: 4, max: 20, message: '长度在 4 到 20 个字符', trigger: 'blur' }
]
}
},
methods: {
submitForm(formName) {
this.$refs[formName].validate((valid) => {
if (valid) {
alert('submit!');
} else {
alert('error submit!!');
return false;
}
});
},
resetForm(formName) {
this.$refs[formName].resetFields();
}
}
})