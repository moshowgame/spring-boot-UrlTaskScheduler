<template>
    <div>
        <el-drawer v-model="isShow" title="应用配置" direction="rtl" :size="350" custom-class="flex-container">
            <div class="container">
                <el-alert title="应用配置可实时预览效果，但仅是临时生效，要想真正作用于项目，可以点击下方的“复制配置”按钮，将配置粘贴到 src/settings.custom.json 中即可，或者也可在 src/settings.js 中直接修改默认配置。同时建议在生产环境隐藏应用配置功能。" type="error" :closable="false" />
                <el-divider>导航栏模式</el-divider>
                <div class="menu-mode">
                    <el-tooltip content="侧边栏模式（含主导航）" placement="top" :show-after="500" :append-to-body="false">
                        <div class="mode mode-side" :class="{'active': settings.menu.menuMode === 'side'}" @click="settings.menu.menuMode = 'side'">
                            <svg-icon name="ri-checkbox-circle-fill" />
                        </div>
                    </el-tooltip>
                    <el-tooltip content="顶部模式" placement="top" :show-after="500" :append-to-body="false">
                        <div class="mode mode-head" :class="{'active': settings.menu.menuMode === 'head'}" @click="settings.menu.menuMode = 'head'">
                            <svg-icon name="ri-checkbox-circle-fill" />
                        </div>
                    </el-tooltip>
                    <el-tooltip content="侧边栏模式（不含主导航）" placement="top" :show-after="500" :append-to-body="false">
                        <div class="mode mode-single" :class="{'active': settings.menu.menuMode === 'single'}" @click="settings.menu.menuMode = 'single'">
                            <svg-icon name="ri-checkbox-circle-fill" />
                        </div>
                    </el-tooltip>
                    <el-tooltip content="侧边栏精简模式" placement="top" :show-after="500" :append-to-body="false">
                        <div class="mode mode-only-side" :class="{'active': settings.menu.menuMode === 'only-side'}" @click="settings.menu.menuMode = 'only-side'">
                            <svg-icon name="ri-checkbox-circle-fill" />
                        </div>
                    </el-tooltip>
                    <el-tooltip content="顶部精简模式" placement="top" :show-after="500" :append-to-body="false">
                        <div class="mode mode-only-head" :class="{'active': settings.menu.menuMode === 'only-head'}" @click="settings.menu.menuMode = 'only-head'">
                            <svg-icon name="ri-checkbox-circle-fill" />
                        </div>
                    </el-tooltip>
                </div>
                <el-divider>导航栏风格</el-divider>
                <div class="menu-style">
                    <el-tooltip content="卡片" placement="top" :show-after="500" :append-to-body="false">
                        <div class="style style-card" :class="{'active': settings.menu.menuStyle === 'card'}" @click="settings.menu.menuStyle = 'card'">
                            <svg-icon name="ri-checkbox-circle-fill" />
                        </div>
                    </el-tooltip>
                    <el-tooltip content="圆角" placement="top" :show-after="500" :append-to-body="false">
                        <div class="style style-radius" :class="{'active': settings.menu.menuStyle === 'radius'}" @click="settings.menu.menuStyle = 'radius'">
                            <svg-icon name="ri-checkbox-circle-fill" />
                        </div>
                    </el-tooltip>
                    <el-tooltip v-if="settingsStore.menu.menuMode !== 'single'" content="箭头" placement="top" :show-after="500" :append-to-body="false">
                        <div
                            class="style" :class="{
                                'style-arrow-right': ['side', 'only-side'].includes(settingsStore.menu.menuMode),
                                'style-arrow-bottom': ['head', 'only-head'].includes(settingsStore.menu.menuMode),
                                'active': settings.menu.menuStyle === 'arrow'
                            }" @click="settings.menu.menuStyle = 'arrow'"
                        >
                            <svg-icon name="ri-checkbox-circle-fill" />
                        </div>
                    </el-tooltip>
                </div>
                <el-divider>主题风格</el-divider>
                <div class="theme">
                    <el-tooltip content="默认" placement="top" :show-after="500" :append-to-body="false">
                        <div class="theme-default" :class="{'active': settings.app.theme === 'default'}" @click="settings.app.theme = 'default'">
                            <div class="content" />
                        </div>
                    </el-tooltip>
                    <el-tooltip content="Vue CLI 风格" placement="top" :show-after="500" :append-to-body="false">
                        <div class="theme-vue-cli" :class="{'active': settings.app.theme === 'vue-cli'}" @click="settings.app.theme = 'vue-cli'">
                            <div class="content" />
                        </div>
                    </el-tooltip>
                    <el-tooltip content="码云风格" placement="top" :show-after="500" :append-to-body="false">
                        <div class="theme-gitee" :class="{'active': settings.app.theme === 'gitee'}" @click="settings.app.theme = 'gitee'">
                            <div class="content" />
                        </div>
                    </el-tooltip>
                    <el-tooltip content="清新" placement="top" :show-after="500" :append-to-body="false">
                        <div class="theme-freshness" :class="{'active': settings.app.theme === 'freshness'}" @click="settings.app.theme = 'freshness'">
                            <div class="content" />
                        </div>
                    </el-tooltip>
                    <el-tooltip content="素雅" placement="top" :show-after="500" :append-to-body="false">
                        <div class="theme-elegant" :class="{'active': settings.app.theme === 'elegant'}" @click="settings.app.theme = 'elegant'">
                            <div class="content" />
                        </div>
                    </el-tooltip>
                    <el-tooltip content="纯白" placement="top" :show-after="500" :append-to-body="false">
                        <div class="theme-pure-white" :class="{'active': settings.app.theme === 'pure-white'}" @click="settings.app.theme = 'pure-white'">
                            <div class="content" />
                        </div>
                    </el-tooltip>
                </div>
                <el-divider>导航栏</el-divider>
                <div class="setting-item">
                    <div class="label">是否折叠</div>
                    <el-switch v-model="settings.menu.subMenuCollapse" :disabled="['only-side', 'only-head'].includes(settings.menu.menuMode)" />
                </div>
                <div class="setting-item">
                    <div class="label">
                        切换打开窗口
                        <el-tooltip content="开启该功能后，切换侧边栏时，将自动打开该侧边栏导航下第一个导航窗口" placement="top" :append-to-body="false">
                            <svg-icon name="ri-question-line" />
                        </el-tooltip>
                    </div>
                    <el-switch v-model="settings.menu.switchMainMenuAndOpenWindow" :disabled="['single', 'only-side', 'only-head'].includes(settings.menu.menuMode)" />
                </div>
                <div class="setting-item">
                    <div class="label">
                        保持展开一个
                        <el-tooltip content="开启该功能后，侧边栏只保持一个子菜单的展开" placement="top" :append-to-body="false">
                            <svg-icon name="ri-question-line" />
                        </el-tooltip>
                    </div>
                    <el-switch v-model="settings.menu.subMenuUniqueOpened" :disabled="['only-side', 'only-head'].includes(settings.menu.menuMode)" />
                </div>
                <el-divider>顶栏</el-divider>
                <div class="setting-item">
                    <div class="label">折叠按钮</div>
                    <el-switch v-model="settings.topbar.enableSidebarCollapse" :disabled="['only-side', 'only-head'].includes(settings.menu.menuMode)" />
                </div>
                <div class="setting-item">
                    <div class="label">
                        导航栏搜索
                        <el-tooltip content="对导航栏进行快捷搜索" placement="top" :append-to-body="false">
                            <svg-icon name="ri-question-line" />
                        </el-tooltip>
                    </div>
                    <el-switch v-model="settings.topbar.enableNavSearch" />
                </div>
                <div class="setting-item">
                    <div class="label">
                        通知中心
                        <el-tooltip content="该功能具体业务功能需自行开发，框架仅提供示例模版" placement="top" :append-to-body="false">
                            <svg-icon name="ri-question-line" />
                        </el-tooltip>
                    </div>
                    <el-switch v-model="settings.topbar.enableNotification" />
                </div>
                <div class="setting-item">
                    <div class="label">国际化</div>
                    <el-switch v-model="settings.topbar.enableI18n" />
                </div>
                <div class="setting-item">
                    <div class="label">
                        全屏
                        <el-tooltip content="该功能使用场景极少，用户习惯于通过窗口“最大化”功能来扩大显示区域，以显示更多内容，并且使用 F11 键也可以进入全屏效果" placement="top" :append-to-body="false">
                            <svg-icon name="ri-question-line" />
                        </el-tooltip>
                    </div>
                    <el-switch v-model="settings.topbar.enableFullscreen" />
                </div>
                <el-divider>窗口</el-divider>
                <div class="setting-item">
                    <div class="label">
                        自动定位
                        <el-tooltip content="滚动后窗口自动定位依据" placement="top" :append-to-body="false">
                            <svg-icon name="ri-question-line" />
                        </el-tooltip>
                    </div>
                    <el-radio-group v-model="settings.window.autoPosition" size="small">
                        <el-radio-button label="none">无</el-radio-button>
                        <el-radio-button label="start">左侧</el-radio-button>
                        <el-radio-button label="center">居中</el-radio-button>
                        <el-radio-button label="end">右侧</el-radio-button>
                    </el-radio-group>
                </div>
                <el-divider>底部版权</el-divider>
                <div class="setting-item">
                    <div class="label">是否启用</div>
                    <el-switch v-model="settings.copyright.enable" />
                </div>
                <div class="setting-item">
                    <div class="label">日期</div>
                    <el-input v-model="settings.copyright.dates" size="small" :disabled="!settings.copyright.enable" />
                </div>
                <div class="setting-item">
                    <div class="label">公司</div>
                    <el-input v-model="settings.copyright.company" size="small" :disabled="!settings.copyright.enable" />
                </div>
                <div class="setting-item">
                    <div class="label">网址</div>
                    <el-input v-model="settings.copyright.website" size="small" :disabled="!settings.copyright.enable" />
                </div>
                <el-divider>其它</el-divider>
                <div class="setting-item">
                    <div class="label">
                        组件尺寸
                        <el-tooltip content="全局设置 Element Plus 组件的默认尺寸大小" placement="top" :append-to-body="false">
                            <svg-icon name="ri-question-line" />
                        </el-tooltip>
                    </div>
                    <el-radio-group v-model="settings.app.elementSize" size="small">
                        <el-radio-button label="large">较大</el-radio-button>
                        <el-radio-button label="default">默认</el-radio-button>
                        <el-radio-button label="small">稍小</el-radio-button>
                    </el-radio-group>
                </div>
                <div class="setting-item">
                    <div class="label">是否启用权限</div>
                    <el-switch v-model="settings.app.enablePermission" />
                </div>
                <div class="setting-item">
                    <div class="label">是否开启后端返回导航数据</div>
                    <el-switch v-model="settings.app.enableBackendReturnMenu" />
                </div>
                <div class="setting-item">
                    <div class="label">
                        Storage 前缀
                        <el-tooltip content="localStorage 和 sessionStorage 的字段前缀" placement="top" :append-to-body="false">
                            <svg-icon name="ri-question-line" />
                        </el-tooltip>
                    </div>
                    <el-input v-model="settings.app.storagePrefix" size="small" style="width: 100px;" />
                </div>
                <div class="setting-item">
                    <div class="label">页面水印</div>
                    <el-switch v-model="settings.app.enableWatermark" />
                </div>
            </div>
            <div v-if="isSupported" class="action-buttons">
                <el-button icon="el-icon-document-copy" type="primary" @click="handleCopy">复制配置</el-button>
            </div>
        </el-drawer>
    </div>
</template>

<script setup name="ThemeSetting">
const { proxy } = getCurrentInstance()

import { useSettingsStore } from '@/store/modules/settings'
const settingsStore = useSettingsStore()
import { useMenuStore } from '@/store/modules/menu'
const menuStore = useMenuStore()

const isShow = ref(false)

import globalSettings from '@/settings'
const settings = ref(globalSettings)

watch(() => settings, () => {
    if (settings.value.menu.menuMode === 'single' && settings.value.menu.menuStyle === 'arrow') {
        settings.value.menu.menuStyle = 'card'
    }
    settingsStore.updateThemeSetting(settings.value)
    menuStore.switchHeaderActived(0)
}, {
    deep: true
})

onMounted(() => {
    proxy.$eventBus.on('global-theme-toggle', () => {
        isShow.value = !isShow.value
    })
})

import { useClipboard } from '@vueuse/core'
const { copy, copied, isSupported } = useClipboard()

watch(copied, val => {
    if (val) {
        proxy.$message.success('复制成功，请粘贴到 src/settings.custom.json 文件中！')
    }
})

function handleCopy() {
    copy(JSON.stringify(settings.value, null, 4))
}
</script>

<style lang="scss" scoped>
:deep(.el-drawer__body) {
    display: flex;
    flex-direction: column;
    overflow: auto;
    padding: 0;
}
:deep(.el-drawer__header) {
    margin-bottom: initial;
    padding-bottom: 20px;
    border-bottom: 1px solid #ddd;
}
.flex-container {
    .container {
        padding: 15px;
        overflow: auto;
        flex: 1;
    }
    .action-buttons {
        padding: 15px;
        text-align: center;
        background-color: #fff;
        border-top: 1px solid #ddd;
        .el-button {
            width: 100%;
        }
    }
}
:deep(.el-divider) {
    margin: 36px 0 24px;
}
.menu-mode {
    display: flex;
    align-items: center;
    justify-content: space-around;
    padding-bottom: 10px;
    .mode {
        position: relative;
        width: 50px;
        height: 40px;
        border-radius: 4px;
        overflow: hidden;
        cursor: pointer;
        background-color: #e1e3e6;
        box-shadow: 0 0 15px 1px #aaa;
        transition: 0.3s;
        &:hover {
            box-shadow: 0 0 15px 1px #666;
        }
        &.active {
            box-shadow: 0 0 0 2px #409eff;
        }
        &::before,
        &::after {
            pointer-events: none;
        }
        &-side {
            &::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 10px;
                height: 100%;
                background-color: #222b45;
            }
            &::after {
                content: "";
                position: absolute;
                top: 0;
                left: 10px;
                width: 15px;
                height: 100%;
                background-color: #fff;
            }
        }
        &-head {
            &::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 10px;
                background-color: #222b45;
            }
            &::after {
                content: "";
                position: absolute;
                top: 10px;
                left: 0;
                width: 15px;
                height: calc(100% - 10px);
                background-color: #fff;
            }
        }
        &-single {
            &::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 15px;
                height: 100%;
                background-color: #fff;
            }
        }
        &-only-side {
            &::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 10px;
                height: 100%;
                background-color: #222b45;
            }
        }
        &-only-head {
            &::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 10px;
                background-color: #222b45;
            }
        }
        i {
            position: absolute;
            right: 2px;
            bottom: 2px;
            display: none;
        }
        &.active i {
            display: block;
            color: #409eff;
        }
    }
}
.menu-style {
    display: flex;
    align-items: center;
    justify-content: space-around;
    padding-bottom: 10px;
    .style {
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        width: 60px;
        height: 30px;
        overflow: hidden;
        cursor: pointer;
        background-color: #334067;
        box-shadow: 0 0 15px 1px #aaa;
        transition: 0.3s;
        &:hover {
            box-shadow: 0 0 15px 1px #666;
        }
        &.active {
            box-shadow: 0 0 0 2px #409eff;
        }
        &-radius {
            border-radius: 10px;
        }
        &-arrow-right {
            &::before {
                content: "";
                position: absolute;
                right: 0;
                top: 50%;
                margin-top: -7px;
                width: 0;
                height: 0;
                border-top: 7px solid transparent;
                border-right: 7px solid #fff;
                border-bottom: 7px solid transparent;
            }
        }
        &-arrow-bottom {
            &::before {
                content: "";
                position: absolute;
                bottom: 0;
                left: 50%;
                margin-left: -7px;
                width: 0;
                height: 0;
                border-left: 7px solid transparent;
                border-right: 7px solid transparent;
                border-bottom: 7px solid #fff;
            }
        }
        i {
            display: none;
        }
        &.active i {
            display: block;
            color: #409eff;
        }
    }
}
.theme {
    display: flex;
    align-items: center;
    justify-content: space-around;
    padding-bottom: 10px;
    [class^="theme-"] {
        position: relative;
        width: 30px;
        height: 30px;
        cursor: pointer;
        border-radius: 5px;
        overflow: hidden;
        box-shadow: 0 0 15px 1px #aaa;
        transition: 0.3s;
        &:hover {
            box-shadow: 0 0 15px 1px #666;
        }
        &::before,
        &::after {
            content: "";
            position: absolute;
            width: 50%;
            height: 50%;
            pointer-events: none;
        }
        &::before {
            top: 0;
            left: 0;
        }
        &::after {
            top: 0;
            left: 50%;
        }
        &.active {
            box-shadow: 0 0 0 2px #409eff;
        }
        .content {
            position: absolute;
            width: 100%;
            height: 100%;
            &::before,
            &::after {
                content: "";
                position: absolute;
                width: 50%;
                height: 50%;
                pointer-events: none;
            }
            &::before {
                bottom: 0;
                left: 0;
            }
            &::after {
                bottom: 0;
                left: 50%;
            }
        }
    }
    .theme-default {
        &::before {
            background-color: map-get($theme-default, "g-header-bg");
        }
        &::after {
            background-color: map-get($theme-default, "g-header-menu-active-bg");
        }
        .content {
            &::before {
                background-color: map-get($theme-default, "g-sub-sidebar-bg");
            }
            &::after {
                background-color: map-get($theme-default, "g-sub-sidebar-menu-active-bg");
            }
        }
    }
    .theme-vue-cli {
        &::before {
            background-color: map-get($theme-vue-cli, "g-header-bg");
        }
        &::after {
            background-color: map-get($theme-vue-cli, "g-header-menu-active-bg");
        }
        .content {
            &::before {
                background-color: map-get($theme-vue-cli, "g-sub-sidebar-bg");
            }
            &::after {
                background-color: map-get($theme-vue-cli, "g-sub-sidebar-menu-active-bg");
            }
        }
    }
    .theme-gitee {
        &::before {
            background-color: map-get($theme-gitee, "g-header-bg");
        }
        &::after {
            background-color: map-get($theme-gitee, "g-header-menu-active-bg");
        }
        .content {
            &::before {
                background-color: map-get($theme-gitee, "g-sub-sidebar-bg");
            }
            &::after {
                background-color: map-get($theme-gitee, "g-sub-sidebar-menu-active-bg");
            }
        }
    }
    .theme-freshness {
        &::before {
            background-color: map-get($theme-freshness, "g-header-bg");
        }
        &::after {
            background-color: map-get($theme-freshness, "g-header-menu-active-bg");
        }
        .content {
            &::before {
                background-color: map-get($theme-freshness, "g-sub-sidebar-bg");
            }
            &::after {
                background-color: map-get($theme-freshness, "g-sub-sidebar-menu-active-bg");
            }
        }
    }
    .theme-elegant {
        &::before {
            background-color: map-get($theme-elegant, "g-header-bg");
        }
        &::after {
            background-color: map-get($theme-elegant, "g-header-menu-active-bg");
        }
        .content {
            &::before {
                background-color: map-get($theme-elegant, "g-sub-sidebar-bg");
            }
            &::after {
                background-color: map-get($theme-elegant, "g-sub-sidebar-menu-active-bg");
            }
        }
    }
    .theme-pure-white {
        &::before {
            background-color: map-get($theme-pure-white, "g-header-bg");
        }
        &::after {
            background-color: map-get($theme-pure-white, "g-header-menu-active-bg");
        }
        .content {
            &::before {
                background-color: map-get($theme-pure-white, "g-sub-sidebar-bg");
            }
            &::after {
                background-color: map-get($theme-pure-white, "g-sub-sidebar-menu-active-bg");
            }
        }
    }
}
.setting-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin: 5px 0;
    padding: 5px 10px;
    border-radius: 5px;
    transition: all 0.3s;
    &:hover {
        background: #f1f1f1;
    }
    .label {
        font-size: 14px;
        color: #666;
        display: flex;
        align-items: center;
        i {
            margin-left: 4px;
            font-size: 17px;
            color: #e6a23c;
            cursor: help;
        }
    }
    .el-switch {
        height: auto;
    }
    .el-input {
        width: 150px;
    }
}
</style>
