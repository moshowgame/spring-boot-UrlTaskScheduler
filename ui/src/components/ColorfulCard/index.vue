<template>
    <el-card
        shadow="hover" class="mini-card" :style="{
            'background': `linear-gradient(50deg, ${colorFrom}, ${colorTo})`
        }"
    >
        <template #header>{{ header }}</template>
        <div class="num">{{ num }}</div>
        <div class="tip">{{ tip }}</div>
        <svg-icon v-if="icon" :name="icon" :rotate="20" />
    </el-card>
</template>

<script setup>
defineProps({
    colorFrom: {
        type: String,
        default: '#843cf6'
    },
    colorTo: {
        type: String,
        default: '#759bff'
    },
    header: {
        type: String,
        default: ''
    },
    num: {
        type: Number,
        default: 0
    },
    tip: {
        type: String,
        default: ''
    },
    icon: {
        type: String,
        default: ''
    }
})
</script>

<style lang="scss" scoped>
.mini-card {
    position: relative;
    color: #fff;
    text-shadow: 0 0 2px #000;
    cursor: pointer;
    :hover {
        .svg-icon {
            right: 0;
            top: 0;
        }
    }
    :deep(.el-card__header) {
        position: relative;
        z-index: 1;
        border-bottom: 0;
        font-size: 18px;
    }
    :deep(.el-card__body) {
        padding-top: 0;
    }
    .num {
        position: relative;
        z-index: 1;
        font-size: 36px;
    }
    .tip {
        margin-top: 10px;
        font-size: 14px;
        color: #eee;
    }
    .svg-icon {
        transition: 0.3s;
        font-size: 120px;
        position: absolute;
        right: -30px;
        top: -10px;
    }
}
</style>
