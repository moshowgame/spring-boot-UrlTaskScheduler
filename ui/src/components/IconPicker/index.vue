<template>
    <el-popover v-model:visible="data.visible" placement="bottom" trigger="hover" :width="250">
        <template #reference>
            <div class="picker-container">
                <svg-icon v-if="data.myValue != ''" :name="data.myValue" />
                <svg-icon v-else name="el-icon-plus" />
            </div>
        </template>
        <el-tabs ref="tabs" v-model="data.activeTab">
            <el-tab-pane label="Element Icon" name="element">
                <el-input v-model="data.element.search" size="small" placeholder="请输入搜索关键词" prefix-icon="el-icon-search" clearable />
                <div class="list-icon">
                    <span v-for="(item, index) in elementIconCurrentList" :key="index" class="list-icon-item" @click="choose(`ElIcon${item}`)">
                        <svg-icon :name="`el-icon-${item}`" />
                    </span>
                </div>
                <el-pagination v-model:current-page="data.element.currentPage" small layout="prev, pager, next" :page-size="data.element.pageSize" :total="elementIconList.length" :pager-count="5" />
            </el-tab-pane>
            <el-tab-pane label="Remix Icon" name="remix">
                <el-input v-model="data.remix.search" size="small" placeholder="请输入搜索关键词" prefix-icon="el-icon-search" clearable />
                <div class="list-icon">
                    <span v-for="(item, index) in remixIconCurrentList" :key="index" class="list-icon-item" @click="choose(item.type == 'Editor' ? `ri-${item.name}` : `ri-${item.name}-${data.remix.style}`)">
                        <svg-icon :name="item.type == 'Editor' ? `ri-${item.name}` : `ri-${item.name}-${data.remix.style}`" />
                    </span>
                </div>
                <div class="style-choose">
                    <el-radio-group v-model="data.remix.style" size="small">
                        <el-radio-button label="line">线条</el-radio-button>
                        <el-radio-button label="fill">填充</el-radio-button>
                    </el-radio-group>
                </div>
                <el-pagination v-model:current-page="data.remix.currentPage" small layout="prev, pager, next" :page-size="data.remix.pageSize" :total="remixIconList.length" :pager-count="5" />
            </el-tab-pane>
        </el-tabs>
    </el-popover>
</template>

<script setup>
import * as ElementIcons from '@element-plus/icons-vue'
import remixIcon from './remix.json'
import { pascal, hyphen } from 'naming-style'

const props = defineProps({
    modelValue: {
        type: String,
        default: ''
    }
})

const emit = defineEmits(['update:modelValue'])

const data = ref({
    visible: false,
    activeTab: 'element',
    element: {
        search: '',
        pageSize: 20,
        currentPage: 1
    },
    remix: {
        search: '',
        style: 'line',
        pageSize: 20,
        currentPage: 1
    },
    myValue: ''
})

const elementIconList = computed(() => {
    let list = Object.keys(ElementIcons)
    if (data.value.element.search != '') {
        list = list.filter(item => {
            return pascal(item).toLowerCase().indexOf(pascal(data.value.element.search).toLowerCase()) >= 0
        })
    }
    return list
})

const elementIconCurrentList = computed(() => {
    return elementIconList.value.slice(
        (data.value.element.currentPage - 1) * data.value.element.pageSize,
        (data.value.element.currentPage - 1) * data.value.element.pageSize + data.value.element.pageSize
    )
})

const remixIconList = computed(() => {
    let list = []
    for (var key in remixIcon) {
        for (var name in remixIcon[key]) {
            list.push({
                name: name,
                type: key,
                keyword: remixIcon[key][name]
            })
        }
    }
    if (data.value.remix.search != '') {
        list = list.filter(item => {
            return item.keyword.includes(data.value.remix.search) || item.name.indexOf(data.value.remix.search) >= 0
        })
    }
    return list
})

const remixIconCurrentList = computed(() => {
    return remixIconList.value.slice(
        (data.value.remix.currentPage - 1) * data.value.remix.pageSize,
        (data.value.remix.currentPage - 1) * data.value.remix.pageSize + data.value.remix.pageSize
    )
})

watch(() => props.modelValue, newValue => {
    data.value.myValue = newValue.indexOf('ElIcon') === 0 ? hyphen(newValue) : newValue
}, {
    immediate: true
})

watch(() => data.value.myValue, newValue => {
    emit('update:modelValue', newValue)
})

function choose(val) {
    data.value.myValue = val
    data.value.visible = false
}
</script>

<style lang="scss" scoped>
.el-tabs {
    margin-top: -10px;
    :deep(.el-tabs__nav-scroll) {
        text-align: center;
        .el-tabs__nav {
            display: inline-block;
            margin: 0 auto;
            float: none;
            .el-tabs__item {
                padding: 0 12px;
            }
        }
    }
}
.picker-container {
    width: 40px;
    height: 40px;
    line-height: 36px;
    text-align: center;
    border: 1px dashed #dcdfe6;
    border-radius: 5px;
    cursor: pointer;
    transition: 0.3s;
    &:hover {
        border-color: #909399;
        border-style: solid;
    }
    i {
        font-size: 24px;
        vertical-align: middle;
        color: #606266;
    }
}
.list-icon {
    .list-icon-item {
        display: inline-block;
        margin-right: 3px;
        margin-bottom: 3px;
        padding: 2px 8px 6px;
        border: 1px solid #dcdfe6;
        font-size: 24px;
        cursor: pointer;
        transition: 0.3s;
        &:nth-child(5n + 5) {
            margin-right: 0;
        }
        &:hover {
            border-color: #c5e1fe;
            background-color: #ecf5ff;
            color: #409eff;
        }
        i {
            vertical-align: middle;
            font-size: inherit;
        }
    }
}
.el-input {
    margin-bottom: 12px;
}
.style-choose {
    margin-top: 5px;
    text-align: center;
}
.el-pagination {
    margin-top: 5px;
    text-align: center;
}
</style>
