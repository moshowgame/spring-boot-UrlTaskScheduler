<template>
    <div>
        <page-header title="断言设置" content="当请求返回了报文，则根据报文内容进行文本模糊匹配，返回对应的推断结果。" />
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
                        <el-form-item label="关键字1">
                            <el-input v-model="form.keyFirst" type="textarea" />
                        </el-form-item>
                        <el-form-item label="推断结果1">
                            <el-input v-model="form.valueFirst" />
                        </el-form-item>
                        <el-form-item label="关键字2">
                            <el-input v-model="form.keySecond" type="textarea" />
                        </el-form-item>
                        <el-form-item label="推断结果2">
                            <el-input v-model="form.valueSecond" />
                        </el-form-item>
                        <el-form-item label="关键字3">
                            <el-input v-model="form.keyThird" type="textarea" />
                        </el-form-item>
                        <el-form-item label="推断结果3">
                            <el-input v-model="form.valueThird" />
                        </el-form-item>
                        <el-form-item label="否则结果">
                            <el-input v-model="form.valueElse" />
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
                requestId: '',
                valueElse: '',
                keyFirst: '',
                keySecond: '',
                keyThird: '',
                valueFirst:'' ,
                valueSecond:'',
                valueThird:'',
                status: '1',
            }
        }
    },
    methods: {
          onSave() {
              this.form.requestId = this.search.requestId
              //validation
              if(this.form.requestId.length<1||this.form.keyFirst.length<2||this.form.valueFirst.length<2||this.form.valueElse.length<2){
                  this.$message.error({
                      message: '请完整填写所需信息！',
                      center: true
                  })
                  return;
              }
              //save request
              this.$api.post('urlPlus/assumption/save', this.form).then(res=>{
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
                  this.$api.post('urlPlus/assumption/info', this.search).then(res=>{
                      // 后续业务代码
                      // console.log(res)
                      if(res.code === 500) {
                          this.$message.error({
                              message: res.msg,
                              center: true
                          })
                          this.form={
                              requestId: '',
                                  valueElse: '',
                                  keyFirst: '',
                                  keySecond: '',
                                  keyThird: '',
                                  valueFirst:'' ,
                                  valueSecond:'',
                                  valueThird:'',
                                  status: '1',
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
