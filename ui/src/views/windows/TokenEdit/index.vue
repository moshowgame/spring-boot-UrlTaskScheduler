<template>
    <div>
        <page-header title="令牌设置" content="当令牌设置启用时，会先请求授权URL获取对应的Token，然后追加到请求的URL参数上去。" />
        <page-main>
            <el-row type="flex" justify="center">
                <el-col :md="12" :sm="18">
                    <el-form :model="form" label-width="80px">
                        <el-form-item label="选择请求">
                            <el-select v-model="search.requestId" class="m-2" placeholder="Select">
                                <el-option @click="getData"
                                    v-for="item in search.responseIdOptions"
                                    :key="item.requestId"
                                    :label="item.requestName"
                                    :value="item.requestId"
                                >
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" icon="el-icon-search" @click="getData">读取</el-button>
                        </el-form-item>
                        <el-form-item label="令牌URL">
                            <el-input v-model="form.tokenUrl" type="textarea" />
                        </el-form-item>
                        <el-form-item label="请求属性">
                            <el-select v-model="form.method" placeholder="请选择method get or post">
                                <el-option label="GET" value="GET" />
                                <el-option label="POST" value="POST" />
                            </el-select>
                        </el-form-item>

<!--                    <el-form-item label="请求ID">
                            <el-input v-model="form.requestId" />
                        </el-form-item>-->
                        <el-form-item label="请求属性">
                            <b>For POST方式才有，Get只有追加参数，post可以选择表单或者JSON</b>
                            <el-select v-model="form.paramType" placeholder="请选择method get or post">
                                <el-option label="JSON参数" value="JSON" />
                                <el-option label="FORM表单参数" value="FORM" />
                            </el-select>
                        </el-form-item>
                        <el-form-item label="追加令牌参数名称">
                            <b>例如这里是token则请求时追加为xxxxxxx?token=xxxx</b>
                            <el-input v-model="form.appendName" />
                        </el-form-item>
                        <el-form-item label="令牌提取">
                            <b>例如{data:{token:"123456"}} 则填data.token</b>
                            <el-input v-model="form.tokenExpression" />
                        </el-form-item>
                        <el-form-item label="令牌使用">
                            <b>在已经获取令牌之后，请求URL时会追加为以下参数</b>
                            <el-input v-model="form.param" type="textarea" />
                        </el-form-item>
                        <el-form-item label="状态">
                            <el-select v-model="form.status" placeholder="请选择启用状态">
                                <el-option label="停用" value="0" />
                                <el-option label="启用" value="1" />
                            </el-select>
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

<script>
export default {
    data() {
        return {
            search: {
                requestId: '',
                responseIdOptions: []
            },
            form: {
                tokenUrl: '',
                requestId: '',
                requestUrl: '',
                requestCron: '',
                requestMethod: 'POST',
                appendName:'' ,
                tokenExpression:'',
                status:"1",
                paramType:'JSON'
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
              this.$api.post('urlPlus/token/save', this.form).then(res=>{
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
               this.$window.remove("TokenEdit")
          },
          getData() {
                  this.$api.post('urlPlus/token/info', this.search).then(res=>{
                      // 后续业务代码
                      // console.log(res)
                      if(res.code === 500) {
                          this.$message.error({
                              message: res.msg,
                              center: true
                          })
                          this.form={
                              tokenUrl: '',
                              requestId: '',
                              requestUrl: '',
                              requestCron: '',
                              requestMethod: 'POST',
                              appendName:'' ,
                              tokenExpression:'',
                              status:1,
                              paramType:'JSON'
                          }
                          this.form.requestId=this.search.requestId
                      }else{
                          this.form = res.data
                      }
                  })
        },
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
    },
    mounted() {
        // this.getData()
        this.getRequestDropdown();
        // console.log(props.params.requestId)
        // this.data().form.requestId = props.params.requestId
    }
}
</script>
