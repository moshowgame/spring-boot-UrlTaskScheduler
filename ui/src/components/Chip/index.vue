<template>
    <div
        class="chip" :class="[
            type ? `chip--${type}` : ''
        ]"
    >
        <div class="content">
            <slot />
            <span v-if="closable" class="closable" @click="emit('close')">
                <el-icon><el-icon-close-bold /></el-icon>
            </span>
        </div>
    </div>
</template>

<script setup>
defineProps({
    type: {
        type: String,
        default: ''
    },
    closable: {
        type: Boolean,
        default: false
    }
})

const emit = defineEmits(['close'])
</script>

<style lang="scss" scoped>
.chip {
    display: inline-block;
    vertical-align: middle;
    padding: 0 10px;
    margin-right: 2px;
    border-radius: 20px;
    background-color: #f0f0f0;
    .content {
        display: flex;
        align-items: center;
        min-height: 28px;
        font-size: 12px;
        :deep(.el-avatar) {
            width: 24px;
            height: 24px;
            line-height: 24px;
            margin-left: -8px;
            margin-right: 5px;
        }
        .closable {
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            margin-left: 5px;
            margin-right: -4px;
            font-size: 14px;
            background-color: #ccc;
            color: #fff;
            &:hover {
                opacity: 0.7;
            }
        }
    }
    &--primary {
        background-color: #409eff;
        color: #fff;
        .content .closable {
            background-color: darken(#409eff, 10);
        }
    }
    &--success {
        background-color: #67c23a;
        color: #fff;
        .content .closable {
            background-color: darken(#409eff, 10);
        }
    }
    &--info {
        background-color: #909399;
        color: #fff;
        .content .closable {
            background-color: darken(#909399, 10);
        }
    }
    &--warning {
        background-color: #e6a23c;
        color: #fff;
        .content .closable {
            background-color: darken(#e6a23c, 10);
        }
    }
    &--danger {
        background-color: #f56c6c;
        color: #fff;
        .content .closable {
            background-color: darken(#f56c6c, 10);
        }
    }
}
</style>
