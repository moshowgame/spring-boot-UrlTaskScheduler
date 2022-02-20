<template>
    <canvas
        :id="domId"
        :ref="domRef" class="app-sign-canvas"
        @mousedown.prevent.stop="handleMousedown"
        @mousemove.prevent.stop="handleMousemove"
        @mouseup.prevent.stop="handleMouseup"
        @mouseleave.prevent.stop="handleMouseleave"
        @touchstart.prevent.stop="handleTouchstart"
        @touchmove.prevent.stop="handleTouchmove"
        @touchend.prevent.stop="handleTouchend"
    >
        您的浏览器不支持canvas技术,请升级浏览器!
    </canvas>
</template>

<script setup>
/**
 * sign-canvas
 * https://github.com/langyuxiansheng/vue-sign-canvas
 * 原插件暂不支持 vue3 ，本代码为基于源代码改写的 vue3 版本
 */
const props = defineProps({
    image: {
        required: false,
        type: [String],
        default: null
    },
    options: {  // 配置项
        required: false,
        type: [Object],
        default: () => null
    }
})

const emit = defineEmits(['confirm'])

const domId = ref(`sign-canvas-${Math.random().toString(36).substr(2)}`) // 生成唯一dom标识
const domRef = ref(null)

let canvas = null // canvas dom对象
let context = null // canvas 画布对象
let dpr = 1
let config = {
    isFullScreen: false, // 是否全屏手写 [Boolean] 可选
    isFullCover: false, // 是否全屏模式下覆盖所有的元素 [Boolean] 可选
    isDpr: false, // 是否使用dpr兼容高分屏 [Boolean] 可选
    lastWriteSpeed: 1, // 书写速度 [Number] 可选
    lastWriteWidth: 2, // 下笔的宽度 [Number] 可选
    lineCap: 'round', // 线条的边缘类型 [butt]平直的边缘 [round]圆形线帽 [square]	正方形线帽
    lineJoin: 'round', // 线条交汇时边角的类型  [bevel]创建斜角 [round]创建圆角 [miter]创建尖角。
    canvasWidth: 600, // canvas宽高 [Number] 可选
    canvasHeight: 600, // 高度  [Number] 可选
    isShowBorder: true, // 是否显示边框 [可选]
    bgColor: '#fcc', // 背景色 [String] 可选 注:这背景色仅仅只是canvas背景,保存的图片仍然是透明的
    borderWidth: 1, // 网格线宽度  [Number] 可选
    borderColor: '#ff787f', // 网格颜色  [String] 可选
    writeWidth: 5, // 基础轨迹宽度  [Number] 可选
    maxWriteWidth: 30, // 写字模式最大线宽  [Number] 可选
    minWriteWidth: 5, // 写字模式最小线宽  [Number] 可选
    writeColor: '#101010', // 轨迹颜色  [String] 可选
    isSign: false, // 签名模式 [Boolean] 默认为非签名模式,有线框, 当设置为true的时候没有任何线框
    imgType: 'png' // 下载的图片格式  [String] 可选为 jpeg  canvas本是透明背景的
}
let resizeTimer = null

watch(() => props.options, () => init(), {
    deep: true
})

onMounted(() => {
    init()
    // 监听窗口变化
    window.addEventListener('resize',  () => {
        if (resizeTimer) clearTimeout(resizeTimer)
        resizeTimer = setTimeout(() => {
            init()
        }, 100)
    })
})

function init() {
    const options = props.options
    if (options) {
        for (const key in options) {
            config[key] = options[key]
        }
    }
    dpr = typeof window !== 'undefined' && config.isDpr ? window.devicePixelRatio || window.webkitDevicePixelRatio || window.mozDevicePixelRatio || 1 : 1
    canvas = document.getElementById(domId.value)
    context = canvas.getContext('2d')
    canvas.style.background = config.bgColor
    if (config.isFullScreen) {
        config.canvasWidth = window.innerWidth || document.body.clientWidth
        config.canvasHeight = window.innerHeight || document.body.clientHeight
        if (config.isFullCover) { // 开启全屏覆盖
            canvas.style.position = 'fixed'
            canvas.style.top = 0
            canvas.style.left = 0
            canvas.style.margin = 0
            canvas.style.zIndex = 20001
        }
    }
    canvas.height = config.canvasWidth
    canvas.width = config.canvasHeight
    canvasInit()
    canvasClear()
}
// 轨迹宽度
function setLineWidth() {
    const nowTime = new Date().getTime()
    const diffTime = nowTime - config.lastWriteTime
    config.lastWriteTime = nowTime
    let returnNum = config.minWriteWidth + (config.maxWriteWidth - config.minWriteWidth) * diffTime / 30
    if (returnNum < config.minWriteWidth) {
        returnNum = config.minWriteWidth
    } else if (returnNum > config.maxWriteWidth) {
        returnNum = config.maxWriteWidth
    }
    returnNum = returnNum.toFixed(2)
    // 写字模式和签名模式
    if (config.isSign) {
        context.lineWidth = config.writeWidth * dpr
    } else {
        const lineWidth = config.lastWriteWidth = config.lastWriteWidth / 4 * 3 + returnNum / 4
        context.lineWidth = lineWidth * dpr
    }
}
// 写开始
function writeBegin(point) {
    config.isWrite = true
    config.lastWriteTime = new Date().getTime()
    config.lastPoint = point
    writeContextStyle()
}
// 绘制轨迹
function writing(point) {
    context.beginPath()
    context.moveTo(config.lastPoint.x * dpr, config.lastPoint.y * dpr)
    context.lineTo(point.x * dpr, point.y * dpr)
    setLineWidth()
    context.stroke()
    config.lastPoint = point
    context.closePath()
}
// 写结束
function writeEnd(point) {
    config.isWrite = false
    config.lastPoint = point
    saveAsImg()
}
// 轨迹样式
function writeContextStyle() {
    context.beginPath()
    context.strokeStyle = config.writeColor
    context.lineCap = config.lineCap
    context.lineJoin = config.lineJoin
}
// 清空画板
function canvasClear() {
    context.save()
    context.strokeStyle = config.writeColor
    context.clearRect(0, 0, canvas.width, canvas.height)
    context.beginPath()
    context.lineWidth = config.borderWidth * dpr
    context.strokeStyle = config.borderColor
    let size = config.borderWidth / 2 * dpr
    if (config.isShowBorder) {
        // 画外面的框
        context.moveTo(size, size)
        context.lineTo(canvas.width - size, size)
        context.lineTo(canvas.width - size, canvas.height - size)
        context.lineTo(size, canvas.height - size)
        context.closePath()
        context.stroke()
    }
    if (config.isShowBorder && !config.isSign) {
        // 画里面的框
        context.moveTo(0, 0)
        context.lineTo(canvas.width, canvas.height)
        context.lineTo(canvas.width, canvas.height / 2)
        context.lineTo(0, canvas.height / 2)
        context.lineTo(0, canvas.height)
        context.lineTo(canvas.width, 0)
        context.lineTo(canvas.width / 2, 0)
        context.lineTo(canvas.width / 2, canvas.height)
        context.stroke()
    }
    emit('confirm', null)
    context.restore()
}
// 保存图片 格式base64
function saveAsImg() {
    const image = new Image()
    image.src = canvas.toDataURL(`image/${config.imgType}`)
    emit('confirm', image.src)
    return image.src
}
// 初始化画板
function canvasInit() {
    canvas.width = config.canvasWidth * dpr
    canvas.height = config.canvasHeight * dpr
    canvas.style.width = `${config.canvasWidth}px`
    canvas.style.height = `${config.canvasHeight}px`
    config.emptyCanvas = canvas.toDataURL(`image/${config.imgType}`)
}
// 鼠标按下 => 下笔
function handleMousedown(e) {
    writeBegin({ x: e.offsetX || e.clientX, y: e.offsetY || e.clientY })
}
// 书写过程 => 下笔书写
function handleMousemove(e) {
    config.isWrite && writing({ x: e.offsetX, y: e.offsetY })
}
// 鼠标松开 => 提笔
function handleMouseup(e) {
    writeEnd({ x: e.offsetX, y: e.offsetY })
}
// 离开书写区域 => 提笔离开
function handleMouseleave(e) {
    config.isWrite = false
    config.lastPoint = { x: e.offsetX, y: e.offsetY }
}

/* ==========================移动端兼容=Start================================ */

// 手指按下 => 下笔
function handleTouchstart(e) {
    const touch = e.targetTouches[0]
    const x = touch.clientX ? touch.clientX - getRect().left :  touch.pageX - offset(touch.target, 'left')
    const y = touch.clientY ? touch.clientY - getRect().top  : touch.pageY - offset(touch.target, 'top')
    writeBegin({ x, y })
}
// 手指移动 => 下笔书写
function handleTouchmove(e) {
    const touch = e.targetTouches[0]
    const x = touch.clientX ? touch.clientX - getRect().left :  touch.pageX - offset(touch.target, 'left')
    const y = touch.clientY ? touch.clientY - getRect().top  : touch.pageY - offset(touch.target, 'top')
    config.isWrite && writing({ x, y })
}
// 手指移动结束 => 提笔离开
function handleTouchend(e) {
    const tcs = e.targetTouches
    const ccs = e.changedTouches
    const touch = tcs && tcs.length && tcs[0] || ccs && ccs.length && ccs[0]
    const x = touch.clientX ? touch.clientX - getRect().left :  touch.pageX - offset(touch.target, 'left')
    const y = touch.clientY ? touch.clientY - getRect().top  : touch.pageY - offset(touch.target, 'top')
    writeEnd({ x, y })
}

/* ==========================移动端兼容=End================================== */

// 下载二维码到本地
function downloadSignImg(name) {
    const c = document.getElementById(domId.value)
    const dataURL = c.toDataURL('image/png')
    saveFile(dataURL, name ? `${name}.${config.imgType}` : `${Date.parse(new Date())}.${config.imgType}`)
}
// 保存文件
function saveFile(data, filename) {
    const saveLink = document.createElementNS('http://www.w3.org/1999/xhtml', 'a')
    saveLink.href = data
    saveLink.download = filename
    const event = document.createEvent('MouseEvents')
    event.initMouseEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null)
    saveLink.dispatchEvent(event)
}
// 获取画布的元素的大小及其相对于视口的位置
function getRect() {
    return domRef.value.getBoundingClientRect()
}
// 获取dom对象的偏移量 可以获取解决position定位的问题
function offset(obj, direction) {
    // 将top,left首字母大写,并拼接成offsetTop,offsetLeft
    const offsetDir = 'offset' + direction[0].toUpperCase() + direction.substring(1)
    let realNum = obj[offsetDir]
    let positionParent = obj.offsetParent  // 获取上一级定位元素对象
    while (positionParent != null) {
        realNum += positionParent[offsetDir]
        positionParent = positionParent.offsetParent
    }
    return realNum
}
// 图片压缩
function dealImage()  {
    // 压缩系数0-1之间
    var quality = 0.6
    var canvas = document.createElement('canvas')
    var ctx = canvas.getContext('2d')
    var dealWidth = 300 // 目标尺寸
    var dealHeight = 200
    canvas.width = dealWidth
    canvas.width = dealHeight
    const c = document.getElementById(domId.value)
    const dataURL = c.toDataURL('image/png')
    ctx.clearRect(0, 0, canvas.width, canvas.height)
    ctx.drawImage(dataURL, 0, 0, canvas.width, canvas.height)
    var ba = canvas.toDataURL('image/jpeg', quality) // 压缩语句
    console.log(ba)
}

defineExpose({
    canvasClear,
    saveAsImg,
    downloadSignImg,
    dealImage
})
</script>
