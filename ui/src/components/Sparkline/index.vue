<template>
    <div class="sparkline">
        <svg ref="sparklineRef" :width="width" :height="height" :stroke-width="strokeWidth" :stroke="strokeColor" :fill="fillColor" />
        <span v-if="tooltip" v-show="tip.show" class="tooltip" :style="[`left: ${tip.left}px`, `top: ${tip.top}px`]">{{ tip.content }}</span>
    </div>
</template>

<script setup>
import sparkline from './sparkline'

const { proxy } = getCurrentInstance()

const props = defineProps({
    value: {
        type: Array,
        require: true
    },
    width: {
        type: Number,
        default: 100
    },
    height: {
        type: Number,
        default: 30
    },
    strokeWidth: {
        type: Number,
        default: 3
    },
    strokeColor: {
        type: String,
        default: '#dc2b33'
    },
    fillColor: {
        type: String,
        default: 'transparent'
    },
    cursorColor: {
        type: String,
        default: '#dc2b33'
    },
    spotColor: {
        type: String,
        default: '#dc2b33'
    },
    tooltip: {
        type: Boolean,
        default: false
    }
})

const tip = ref({
    show: false,
    content: '',
    top: 0,
    left: 0
})

onMounted(() => {
    sparkline(proxy.$refs.sparklineRef, props.value, props.tooltip && {
        onmousemove: (event, datapoint) => {
            tip.value.show = true
            tip.value.content = datapoint.tooltip
            tip.value.top = event.offsetY
            tip.value.left = event.offsetX + 20
        },
        onmouseout: () => {
            tip.value.show = false
        }
    })
})
</script>

<style lang="scss" scoped>
.sparkline {
    position: relative;
    :deep(.sparkline--cursor) {
        stroke: v-bind("cursorColor");
    }
    :deep(.sparkline--spot) {
        fill: v-bind("spotColor");
        stroke: v-bind("spotColor");
    }
    .tooltip {
        position: absolute;
        background: rgb(0 0 0 / 70%);
        color: #fff;
        padding: 2px 5px;
        font-size: 12px;
        white-space: nowrap;
        z-index: 9999;
    }
}
</style>
