<template>
    <div>
        <page-header title="编辑请求" content="CRON表达式例子，【0 0/15 * * * ? *】十五分钟一次，【0 0 0/6 * * ? *】六小时一次。" />
        <page-main>
            <el-row type="flex" justify="center">
                <el-col :md="12" :sm="18">
                    <el-form :model="form" label-width="80px">
<!--                        <el-form-item label="请求ID">
                            <el-input v-model="params.requestId" />
                        </el-form-item>-->
                        <el-form-item label="请求名称">
                            <el-input v-model="form.requestName" />
                        </el-form-item>
                        <el-form-item label="请求属性">
                            <el-select v-model="form.requestMethod" placeholder="请选择method get or post">
                                <el-option label="GET" value="GET" />
                                <el-option label="POST" value="POST" />
                            </el-select>
                        </el-form-item>
                        <el-form-item label="请求URL">
                            <el-input v-model="form.requestUrl" type="textarea" />
                        </el-form-item>
                        <el-form-item label="CRON表达式">
                            <el-input v-model="form.requestCron" type="textarea" />
                        </el-form-item>
                        <el-form-item>
<!--                            <el-button type="primary" @click="getData">获取</el-button>-->
                            <el-button type="primary" @click="onSave">保存</el-button>
                            <el-button @click="onClose">取消</el-button>
                        </el-form-item>
                    </el-form>
                </el-col>
            </el-row>
        </page-main>
    </div>
</template>

<script setup>
defineProps({
    params: {
        type: Object
    }
})
</script>

<script>
export default {
    data() {
        return {
            form: {
                requestName: '',
                requestId: '',
                requestUrl: '',
                requestCron: '',
                requestMethod: 'POST'
            }
        }
    },
    methods: {
          onSave() {
              //validation
              if(this.form.requestName.length<6||this.form.requestUrl.length<6||this.form.requestCron.length<6){
                  this.$message.error({
                      message: '请完整填写所需信息！',
                      center: true
                  })
                  return;
              }
              //save request
              this.$api.post('urlTask/request/save', this.form).then(res=>{
                  // 后续业务代码
                  console.log(res)
                  if(res.code === 0 || res.code === 200 ) {
                      this.$message.success({
                          message: res.msg,
                          center: true
                      })
                  }else{
                      this.$message.error({
                          message: res.msg,
                          center: true
                      })
                  }

              })
          },
            onClose(){
                this.$window.remove("RequestEdit")
            },
          getData() {
              if(this.params.requestId !== ''){
                  this.form.requestId = this.params.requestId
                  this.$api.post('urlTask/request/info', this.form).then(res=>{
                      // 后续业务代码
                      // console.log(res)
                      this.form = res.data
                  })
              }
        }
    },
    mounted() {
        this.getData()
        // console.log(props.params.requestId)
        // this.data().form.requestId = props.params.requestId
    }
}
</script>
