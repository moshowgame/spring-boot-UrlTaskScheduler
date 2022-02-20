<template>
    <el-config-provider :locale="locales[settingsStore.app.defaultLang]" :size="settingsStore.app.elementSize">
        <RouterView
            :style="{
                '--g-main-sidebar-actual-width': mainSidebarActualWidth,
                '--g-sub-sidebar-actual-width': subSidebarActualWidth
            }"
        />
        <!-- <ReloadPrompt /> -->
    </el-config-provider>
</template>

<script setup>
import { getElementLocales } from '@/locales'
// import ReloadPrompt from '@/pwa/reloadPrompt.vue'

const { proxy } = getCurrentInstance()

import { useSettingsStore } from '@/store/modules/settings'
const settingsStore = useSettingsStore()

provide('generateI18nTitle', generateI18nTitle)

const locales = computed(() => getElementLocales())

// 侧边栏主导航当前实际宽度
const mainSidebarActualWidth = computed(() => {
    let actualWidth = getComputedStyle(document.documentElement).getPropertyValue('--g-main-sidebar-width')
    actualWidth = parseInt(actualWidth)
    if (['head', 'single', 'only-head'].includes(settingsStore.menu.menuMode)) {
        actualWidth = 0
    }
    return `${actualWidth}px`
})

// 侧边栏次导航当前实际宽度
const subSidebarActualWidth = computed(() => {
    let actualWidth = getComputedStyle(document.documentElement).getPropertyValue('--g-sub-sidebar-width')
    actualWidth = parseInt(actualWidth)
    if (settingsStore.menu.subMenuCollapse) {
        actualWidth = 64
    }
    if (['only-side', 'only-head'].includes(settingsStore.menu.menuMode)) {
        actualWidth = 0
    }
    return `${actualWidth}px`
})

watch(() => settingsStore.app.theme, () => {
    document.body.setAttribute('data-theme', settingsStore.app.theme)
}, {
    immediate: true
})

watch(() => settingsStore.menu.menuMode, () => {
    document.body.setAttribute('data-menu-mode', settingsStore.menu.menuMode)
}, {
    immediate: true
})

watch(() => settingsStore.title, () => {
    document.title = import.meta.env.VITE_APP_TITLE
}, {
    immediate: true
})

function generateI18nTitle(key, defaultTitle) {
    return !!key && proxy.$te(key) ? proxy.$t(key) : defaultTitle
}
</script>
