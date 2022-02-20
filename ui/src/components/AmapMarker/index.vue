<template>
    <div class="map">
        <el-autocomplete v-model="search" class="search" :fetch-suggestions="onSearch" :trigger-on-focus="false" clearable prefix-icon="el-icon-location-information" placeholder="请输入地址关键字" @select="onSelect">
            <template #default="{ item }">
                <div class="search-name">{{ item.name }}</div>
                <span class="search-address" :title="item.district + item.address">{{ item.district + item.address }}</span>
            </template>
        </el-autocomplete>
        <div id="amap" :style="`height:${realHeight};`" />
    </div>
</template>

<script setup>
const props = defineProps({
    v: {
        type: String,
        default: '1.4.15'
    },
    appkey: {
        type: String,
        default: ''
    },
    height: {
        type: [Number, String],
        default: 500
    },
    lnglat: {
        type: Array,
        default: () => []
    }
})

const emit = defineEmits(['update:lnglat'])

const search = ref('')

let map = '', marker = '', autoComplete = ''

const realHeight = computed(() => {
    return typeof props.height == 'string' ? props.height : `${props.height}px`
})

onMounted(() => {
    if (typeof AMap === 'undefined') {
        let script = document.createElement('script')
        script.charset = 'UTF-8'
        script.src = `https://webapi.amap.com/maps?v=${props.v}&key=${props.appkey}&plugin=AMap.Autocomplete`
        document.head.appendChild(script)
        script.onload = () => {
            init()
        }
    } else {
        nextTick(() => {
            init()
        })
    }
})

function init() {
    map = new AMap.Map('amap', {
        zoom: 12
    })
    AMap.plugin('AMap.ToolBar', () => {
        let toolbar = new AMap.ToolBar()
        map.addControl(toolbar)
    })
    marker = new AMap.Marker({
        draggable: true,
        cursor: 'move'
    })
    marker.on('dragend', e => {
        emit('update:lnglat', [e.lnglat.lng, e.lnglat.lat])
    })
    autoComplete = new AMap.Autocomplete()
    map.on('click', e => {
        addMarket(e.lnglat.getLng(), e.lnglat.getLat())
    })
    if (props.lnglat.length == 2) {
        addMarket(props.lnglat[0], props.lnglat[1])
    }
}
function addMarket(lng, lat) {
    map.remove(marker)
    marker.setPosition([lng, lat])
    map.add(marker)
    map.setFitView()
    emit('update:lnglat', [lng, lat])
}
function onSearch(queryString, cb) {
    autoComplete.search(queryString, (status, result) => {
        cb(result.tips)
    })
}
function onSelect(item) {
    search.value = item.name
    item.location ? addMarket(item.location.lng, item.location.lat) : map.setCity(item.adcode)
}
</script>

<style lang="scss" scoped>
.search-name {
    padding-top: 10px;
    line-height: normal;
    @include text-overflow;
}
.search-address {
    font-size: 12px;
    color: #b4b4b4;
    line-height: normal;
}
.map {
    position: relative;
    :deep(.search) {
        position: absolute;
        z-index: 1;
        left: 72px;
        top: 15px;
        .el-input input {
            box-shadow: 0 0 5px #999;
        }
    }
}
</style>
