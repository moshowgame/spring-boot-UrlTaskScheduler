<template>
    <div
        ref="windows" class="dashboard" :class="{
            [`scroll-snap-${settingsStore.window.autoPosition}`]: settingsStore.window.autoPosition !== 'none',
            'preview-all': settingsStore.previewAllWindows,
            'focus': focusEnabled,
            [`focus-${focusList.length}`]: focusEnabled
        }" @click="exitPreviewAllWindows"
    >
        <div class="preview-all-mode">
            <el-radio-group v-model="previewAllMode" style="display: inline-block;" @click.stop>
                <el-radio-button label="preview">预 览</el-radio-button>
                <el-radio-button label="focus">专 注</el-radio-button>
                <el-radio-button label="drag">排 序</el-radio-button>
            </el-radio-group>
            <el-tooltip content="可以通过快捷键 Alt + W 快速进入窗口预览界面" placement="left" :append-to-body="false">
                <svg-icon name="ri-question-line" class="help" />
            </el-tooltip>
        </div>
        <div v-if="previewAllMode === 'focus'" class="preview-all-focus-tips">
            请点击勾选 2 至 4 个窗口
        </div>
        <draggable
            v-if="windowStore.list.length > 0" v-model="windowList" class="dashboard-container" :class="{
                'mode-drag': settingsStore.previewAllWindows && previewAllMode === 'drag',
                'mode-focus': settingsStore.previewAllWindows && previewAllMode === 'focus',
                'dragging': isDragging
            }" v-bind="dragOptions" item-key="name" draggable=".window" handle=".draggable" tag="transition-group" :component-data="{
                tag: 'div',
                type: 'transition-group',
                name: !isDragging ? 'window' : null
            }" @start="isDragging = true" @end="isDragging = false"
        >
            <template #item="{element}">
                <div
                    :ref="`window-${element.name}`" class="window" :class="{
                        [`window-focus-${focusList.findIndex(item => item === element.name) + 1}`]: focusEnabled && focusList.findIndex(item => item === element.name) >= 0
                    }" @click.stop
                >
                    <div
                        class="window-container" :class="{
                            'maximize': element.isMaximize,
                            'preview': settingsStore.previewAllWindows
                        }"
                    >
                        <div v-if="element.showTitle !== false" class="header" @dblclick="scrollToWindow(element.name)" @contextmenu="onWindowContextmenu($event, element)">
                            <div class="titles">
                                <el-tooltip v-if="element.title" effect="dark" :content="element.breadcrumbNeste.map(bc => generateI18nTitle(bc.i18n, bc.title)).join(' / ')" placement="bottom-start" :show-after="500" :disabled="element.breadcrumbNeste.map(b => b.title).length == 0">
                                    <span class="title">
                                        {{ generateI18nTitle(element.i18n, element.title) }}
                                    </span>
                                </el-tooltip>
                            </div>
                            <div class="btns" @dblclick.stop>
                                <div class="btn" @click="$window.toggleMaximize(element.name)">
                                    <svg-icon name="ri-picture-in-picture-exit-line" />
                                </div>
                                <div class="btn" @click="$window.remove(element.name)">
                                    <el-icon>
                                        <el-icon-close-bold />
                                    </el-icon>
                                </div>
                            </div>
                        </div>
                        <div class="maximize-exit" @click="$window.toggleMaximize(element.name)">
                            <svg-icon name="ri-picture-in-picture-2-line" />
                        </div>
                        <div class="container">
                            <el-scrollbar>
                                <Component :is="element.name" v-if="!element.reload" :is-maximize="element.isMaximize" :params="element.params" />
                            </el-scrollbar>
                        </div>
                        <div class="mask" @click="maskClick(element.name)" />
                        <div class="focus-check" :class="{'checked': focusList.includes(element.name)}" @click.stop="focusToggle(element.name)">
                            <el-icon>
                                <el-icon-check />
                            </el-icon>
                        </div>
                        <div class="draggable" @click.stop>
                            <div class="title">{{ generateI18nTitle(element.i18n, element.title) }}</div>
                        </div>
                    </div>
                </div>
            </template>
        </draggable>
        <Empty v-else />
        <div v-if="(settingsStore.previewAllWindows && previewAllMode === 'focus') || focusEnabled" class="preview-all-focus-actions">
            <el-button v-if="settingsStore.previewAllWindows && previewAllMode === 'focus'" :disabled="focusList.length < 2" @click.stop="intoFocus">开启专注模式</el-button>
            <el-button v-if="focusEnabled" @click.stop="exitFocus">退出专注模式</el-button>
        </div>
    </div>
</template>

<script setup name="Dashboard">
import storage from '@/util/storage'
import Empty from './Empty/index.vue'
import draggable from 'vuedraggable'

const { proxy } = getCurrentInstance()

import { useSettingsStore } from '@/store/modules/settings'
const settingsStore = useSettingsStore()
import { useWindowStore } from '@/store/modules/window'
const windowStore = useWindowStore()

const generateI18nTitle = inject('generateI18nTitle')
const previewAllMode = ref('preview')

const isDragging = ref(false)
const dragOptions = computed(() => {
    return {
        animation: 200,
        ghostClass: 'window-ghost'
    }
})

const focusList = ref([])
const focusEnabled = ref(false)
function focusToggle(windowName) {
    if (focusList.value.includes(windowName)) {
        focusList.value = focusList.value.filter(item => item !== windowName)
    } else {
        if (focusList.value.length < 4) {
            focusList.value.push(windowName)
        } else {
            proxy.$message({
                type: 'warning',
                message: '最多可勾选不超过 4 个窗口',
                center: true
            })
        }
    }
}
function intoFocus() {
    focusEnabled.value = true
    exitPreviewAllWindows()
}

const windowList = computed({
    get() {
        return windowStore.list
    },
    set(value) {
        windowStore.sort(value)
    }
})

proxy.$eventBus.on('scrollToWindow', windowName => scrollToWindow(windowName))

// 记录进入窗口预览界面前 scrollLeft 的值，退出的时候可以进行复原
const originalScrollLeft = ref(0)
watch(() => settingsStore.previewAllWindows, val => {
    if (val) {
        previewAllMode.value = 'preview'
        focusList.value = []
        originalScrollLeft.value = proxy.$refs['windows'].scrollLeft
    }
})

onMounted(() => {
    proxy.$hotkeys('alt+w', e => {
        if (windowStore.list.length > 1 && windowStore.list.every(item => !item.isMaximize)) {
            e.preventDefault()
            if (settingsStore.previewAllWindows) {
                exitPreviewAllWindows()
            } else {
                settingsStore.updateThemeSetting({
                    previewAllWindows: true
                })
            }
        }
    })
})

function scrollToOriginal(scrollLeft) {
    nextTick(() => {
        proxy.$refs['windows'].scroll(scrollLeft, 0)
    })
}
function scrollToWindow(windowName) {
    nextTick(() => {
        const offsetLeft = proxy.$refs[`window-${windowName}`].offsetLeft
        proxy.$refs['windows'].scrollTo({
            left: offsetLeft,
            behavior: 'smooth'
        })
    })
}
function scrollToPrevWindow(windowName) {
    let index = windowStore.list.findIndex(item => item.name === windowName)
    if (index > 0) {
        scrollToWindow(windowStore.list[index - 1].name)
    }
}
function scrollToNextWindow(windowName) {
    let index = windowStore.list.findIndex(item => item.name === windowName)
    if (index + 1 <= windowStore.list.length) {
        scrollToWindow(windowStore.list[index + 1].name)
    }
}
function onWindowContextmenu(event, windowItem) {
    event.preventDefault()
    proxy.$contextmenu({
        x: event.x,
        y: event.y,
        zIndex: 1000,
        iconFontClass: '',
        customClass: 'contextmenu-custom',
        items: [
            {
                label: proxy.$t('window.reload'),
                icon: 'ri-refresh-line',
                onClick: () => proxy.$window.reload(windowItem.name)
            },
            {
                label: proxy.$t('window.remove'),
                icon: 'ri-close-line',
                divided: true,
                onClick: () => proxy.$window.remove(windowItem.name)
            },
            {
                label: proxy.$t('window.maximize'),
                icon: 'ri-picture-in-picture-exit-line',
                onClick: () => proxy.$window.toggleMaximize(windowItem.name)
            },
            {
                label: proxy.$t('window.focus'),
                icon: 'ri-focus-3-line',
                divided: true,
                onClick: () => {
                    scrollToWindow(windowItem.name)
                    if (!storage.local.has('windowFocusTip')) {
                        proxy.$confirm('你可以通过双击标题栏快速聚焦窗口', '温馨提示', {
                            confirmButtonText: '知道了',
                            showCancelButton: false,
                            showClose: false,
                            closeOnClickModal: false,
                            closeOnPressEscape: false,
                            type: 'info',
                            center: true
                        }).then(() => {
                            storage.local.set('windowFocusTip', true)
                        })
                    }
                }
            },
            {
                label: proxy.$t('window.focusPrev'),
                disabled: windowStore.list[0].name === windowItem.name,
                onClick: () => scrollToPrevWindow(windowItem.name)
            },
            {
                label: proxy.$t('window.focusNext'),
                disabled: windowStore.list[windowStore.list.length - 1].name === windowItem.name,
                divided: true,
                onClick: () => scrollToNextWindow(windowItem.name)
            },
            {
                label: proxy.$t('window.removeOtherSide'),
                disabled: !windowStore.list.some(item => item.name !== windowItem.name),
                onClick: () => {
                    windowStore.removeOtherSide(windowItem.name)
                }
            },
            {
                label: proxy.$t('window.removeLeftSide'),
                disabled: windowStore.list[0].name === windowItem.name,
                onClick: () => {
                    windowStore.removeLeftSide(windowItem.name)
                }
            },
            {
                label: proxy.$t('window.removeRightSide'),
                disabled: windowStore.list[windowStore.list.length - 1].name === windowItem.name,
                onClick: () => {
                    windowStore.removeRightSide(windowItem.name)
                }
            }
        ]
    })
}

function exitPreviewAllWindows() {
    if (settingsStore.previewAllWindows) {
        settingsStore.updateThemeSetting({
            previewAllWindows: false
        })
        scrollToOriginal(originalScrollLeft.value)
    }
}
function exitFocus() {
    if (focusEnabled.value) {
        focusEnabled.value = false
        focusList.value = []
    }
}
function maskClick(windowName) {
    exitPreviewAllWindows()
    setTimeout(() => {
        scrollToWindow(windowName)
    }, 0)
}
</script>

<style lang="scss">
.contextmenu-custom {
    .mx-context-menu-items .mx-context-menu-item {
        .text {
            display: flex;
            align-items: center;
        }
        &.disabled .text .icon {
            color: #9f9f9f;
        }
    }
}
</style>
<style lang="scss" scoped>
.dashboard {
    position: absolute;
    top: 0;
    bottom: 0;
    width: 100%;
    overflow-x: auto;
    overflow-y: hidden;
    transition: 0.3s;
    &[class*="scroll-snap"] {
        scroll-snap-type: x mandatory;
    }
    &.scroll-snap-start .window {
        scroll-snap-align: start;
    }
    &.scroll-snap-center .window {
        scroll-snap-align: center;
    }
    &.scroll-snap-end .window {
        scroll-snap-align: end;
    }
    &.preview-all {
        position: fixed;
        z-index: 2000;
        top: 0;
        bottom: 0;
        left: 0;
        overflow-y: auto;
        background-color: rgb(0 0 0 / 50%);
        backdrop-filter: blur(10px);
        .preview-all-mode,
        .preview-all-focus-tips,
        .preview-all-focus-actions {
            display: block;
        }
        .dashboard-container {
            flex-wrap: wrap;
            justify-content: center;
            bottom: auto;
            padding-bottom: 8px;
            height: max-content;
            &:not(.mode-drag) {
                align-items: center;
                .window {
                    width: 800;
                    height: 800px;
                    margin-right: calc(800px * ($g-window-perview-scale - 1));
                    margin-bottom: calc(800px * ($g-window-perview-scale - 1));
                    transform-origin: top left;
                    transform: scale($g-window-perview-scale);
                    user-select: none;
                }
            }
            &.mode-focus .window {
                .window-container {
                    > .mask {
                        display: none;
                    }
                    .focus-check {
                        display: flex;
                    }
                }
            }
            &.mode-drag .window {
                width: 200px;
                margin-right: unset;
                .window-container {
                    margin: 8px;
                    > * {
                        display: none;
                    }
                    .draggable {
                        display: block;
                    }
                }
            }
        }
    }
    .preview-all-mode {
        display: none;
        padding: 20px 0;
        text-align: center;
        position: relative;
        .help {
            color: #ccc;
            right: 20px;
            font-size: 18px;
            @include position-center(y);
        }
    }
    .preview-all-focus-tips {
        display: none;
        padding: 0 0 20px;
        text-align: center;
        color: #ccc;
    }
    .preview-all-focus-actions {
        display: none;
        padding: 20px 0;
        text-align: center;
    }
    &.focus {
        position: fixed;
        z-index: 2000;
        top: 0;
        bottom: 0;
        left: 0;
        overflow-y: auto;
        background-color: rgb(0 0 0 / 50%);
        backdrop-filter: blur(10px);
        .dashboard-container {
            height: calc(100% - 80px);
            align-items: stretch;
            justify-content: space-between;
            > .window {
                display: none;
                flex: unset;
                width: 100%;
                padding: 10px;
                margin-right: unset;
                overflow: auto;
                .window-container {
                    margin: 0;
                    width: 100%;
                    height: 100%;
                    .header {
                        display: none;
                    }
                }
            }
        }
        .preview-all-focus-actions {
            display: block;
        }
        &-2,
        &-3,
        &-4 {
            .dashboard-container {
                > .window-focus-1,
                > .window-focus-2,
                > .window-focus-3,
                > .window-focus-4 {
                    display: block;
                }
            }
        }
    }
    .dashboard-container {
        display: flex;
        height: 100%;
    }
    .window {
        flex: none;
        display: flex;
        width: 800px;
        margin-right: -16px;
        &.window-ghost {
            opacity: 0;
        }
        .window-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            width: calc(100% - 32px);
            margin: 16px;
            background-color: #fff;
            box-shadow: 0 0 1px 0 #ccc;
            transition: 0.3s;
            &:hover {
                box-shadow: 0 0 5px 0 #ccc;
            }
            &.maximize {
                position: fixed;
                z-index: 2000;
                margin: 0;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                .header {
                    display: none;
                }
                .maximize-exit {
                    display: block;
                }
            }
            &.preview {
                .mask {
                    display: block;
                }
            }
            .header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 10px;
                height: 40px;
                border-bottom: 1px solid #eee;
                .titles {
                    display: flex;
                    align-items: center;
                    .title {
                        font-weight: bold;
                        font-size: 14px;
                    }
                    .title + .btns {
                        margin-left: 10px;
                    }
                }
                .btns {
                    display: flex;
                    .btn {
                        transition: 0.3s;
                        opacity: 0.5;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        padding: 5px;
                        font-size: 16px;
                        border-radius: 3px;
                        background-color: rgb(238 238 238 / 50%);
                        cursor: pointer;
                        &.disabled {
                            color: #ccc;
                            cursor: not-allowed;
                        }
                        &:not(.disabled):hover {
                            opacity: 1;
                            background-color: #eee;
                        }
                    }
                    .btn + .btn {
                        margin-left: 5px;
                    }
                }
            }
            .maximize-exit {
                display: none;
                position: fixed;
                z-index: 1000;
                right: -40px;
                top: -40px;
                width: 80px;
                height: 80px;
                border-radius: 50%;
                background-color: rgb(0 0 0 / 30%);
                cursor: pointer;
                transition: 0.3s;
                .svg-icon {
                    position: absolute;
                    bottom: 16px;
                    left: 16px;
                    transition: 0.3s;
                }
                &:hover {
                    background-color: rgb(0 0 0 / 70%);
                    .svg-icon {
                        color: #fff;
                    }
                }
            }
            .container {
                flex: 1;
                overflow: auto;
                overscroll-behavior: contain;
                :deep(.el-scrollbar__wrap) {
                    padding: $g-window-container-padding;
                }
            }
            .mask {
                display: none;
                position: absolute;
                z-index: 1000;
                margin: 16px;
                top: 0;
                left: 0;
                width: calc(100% - 32px);
                height: calc(100% - 32px);
                background-color: rgb(255 255 255 / 50%);
                cursor: pointer;
                transition: 0.3s;
                &:hover {
                    background-color: rgb(64 158 255 / 30%);
                }
            }
            .focus-check {
                display: none;
                align-items: center;
                justify-content: center;
                position: absolute;
                z-index: 1000;
                margin: 16px;
                top: 0;
                left: 0;
                width: calc(100% - 32px);
                height: calc(100% - 32px);
                background-color: rgb(255 255 255 / 50%);
                cursor: pointer;
                transition: 0.3s;
                &.checked .el-icon {
                    display: block;
                }
                .el-icon {
                    display: none;
                    color: #5482ee;
                    font-size: 100px;
                }
            }
            .draggable {
                display: none;
                padding: 10px;
                cursor: move;
                .title {
                    font-size: 14px;
                    height: 48px;
                    line-height: 24px;
                    @include text-overflow(2, fales);
                }
            }
        }
        &:last-child {
            margin-right: 0;
        }
    }
}
.window-enter-from {
    opacity: 0;
    transform: translateY(100px);
}
.window-enter-active {
    transition: all 0.5s;
}
</style>
