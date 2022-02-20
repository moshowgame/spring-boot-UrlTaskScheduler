<template>
    <div class="user">
        <div class="tools">
            <span v-if="windowStore.list.length > 1" class="item">
                <svg-icon name="toolbar-preview-windows" @click="previewAllWindows" />
            </span>
            <span v-if="settingsStore.topbar.enableNavSearch" class="item" @click="$eventBus.emit('global-search-toggle')">
                <i class="ri-search-line" />
            </span>
            <el-popover v-if="settingsStore.topbar.enableNotification" trigger="hover" :show-after="200" placement="bottom" :width="350">
                <Notification ref="tabs" />
                <template #reference>
                    <span class="item">
                        <el-badge type="primary" :value="5">
                            <i class="ri-notification-3-line" />
                        </el-badge>
                    </span>
                </template>
            </el-popover>
            <i18n-selector>
                <span class="item">
                    <i class="ri-translate" />
                </span>
            </i18n-selector>
            <span v-if="settingsStore.topbar.enableFullscreen" class="item" @click="toggle">
                <i :class="isFullscreen ? 'ri-fullscreen-exit-line' : 'ri-fullscreen-line'" />
            </span>
            <span v-if="settingsStore.topbar.enableAppSetting" class="item" @click="$eventBus.emit('global-theme-toggle')">
                <svg-icon name="toolbar-theme" />
            </span>
        </div>
        <el-dropdown class="user-container" @command="userCommand">
            <div class="user-wrapper">
                <el-avatar size="small">
                    <el-icon><el-icon-user-filled /></el-icon>
                </el-avatar>
                {{ userStore.account }}
                <el-icon><el-icon-caret-bottom /></el-icon>
            </div>
            <template #dropdown>
                <el-dropdown-menu class="user-dropdown">
                    <el-dropdown-item command="setting">{{ $t('app.profile') }}</el-dropdown-item>
                    <el-dropdown-item divided command="logout">{{ $t('app.logout') }}</el-dropdown-item>
                </el-dropdown-menu>
            </template>
        </el-dropdown>
    </div>
</template>

<script setup name="UserMenu">
import Notification from './Notification/index.vue'

const { proxy } = getCurrentInstance()
const router = useRouter()

import { useSettingsStore } from '@/store/modules/settings'
const settingsStore = useSettingsStore()
import { useUserStore } from '@/store/modules/user'
const userStore = useUserStore()
import { useWindowStore } from '@/store/modules/window'
const windowStore = useWindowStore()

import { useFullscreen } from '@vueuse/core'
const { isFullscreen, toggle } = useFullscreen()

function previewAllWindows() {
    settingsStore.updateThemeSetting({
        previewAllWindows: true
    })
}

function userCommand(command) {
    switch (command) {
        case 'setting':
            proxy.$window.add({
                title: '个人设置',
                name: 'PersonalSetting'
            })
            break
        case 'logout':
            userStore.logout().then(() => {
                router.push({
                    name: 'login'
                })
            })
            break
    }
}
</script>

<style lang="scss" scoped>
.user {
    display: flex;
    align-items: center;
    padding: 0 20px;
    white-space: nowrap;
}
.tools {
    margin-right: 20px;
    .item {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        height: 24px;
        width: 34px;
        cursor: pointer;
        vertical-align: middle;
        transition: all 0.3s;
        [class^="ri-"] {
            vertical-align: -0.15em;
        }
        .el-badge {
            vertical-align: initial;
        }
    }
}
:deep(.language-container) {
    font-size: 16px;
}
:deep(.user-container) {
    display: inline-block;
    height: 24px;
    line-height: 24px;
    cursor: pointer;
    .user-wrapper {
        .el-avatar {
            vertical-align: middle;
            margin-top: -2px;
            margin-right: 4px;
        }
    }
}
</style>
