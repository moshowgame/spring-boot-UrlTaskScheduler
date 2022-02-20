<template>
    <transition name="main-sidebar">
        <div v-if="['side', 'only-side'].includes(settingsStore.menu.menuMode)" class="main-sidebar-container">
            <Logo :show-title="false" class="sidebar-logo" />
            <!-- 侧边栏模式（含主导航） -->
            <div
                v-if="settingsStore.menu.menuMode === 'side'" class="nav" :class="{
                    'nav-radius': settingsStore.menu.menuStyle === 'radius',
                    'nav-arrow': settingsStore.menu.menuStyle === 'arrow'
                }"
            >
                <template v-for="(item, index) in menuStore.transformMenus">
                    <div
                        v-if="item.children && item.children.length !== 0" :key="index" :class="{
                            'item': true,
                            'active': index === menuStore.headerActived
                        }" :title="item.title" @click="switchMenu(index)"
                    >
                        <svg-icon v-if="item.icon" :name="item.icon" />
                        <span>{{ item.title }}</span>
                    </div>
                </template>
            </div>
            <!-- 侧边栏精简模式 -->
            <el-menu
                v-else-if="settingsStore.menu.menuMode === 'only-side'" collapse class="el-menu-nav" :class="{
                    'el-menu-nav-radius': settingsStore.menu.menuStyle === 'radius',
                    'el-menu-nav-arrow': settingsStore.menu.menuStyle === 'arrow'
                }"
            >
                <template v-for="(route, index) in menuStore.transformMenus" :key="index">
                    <SidebarItem :item="route" />
                </template>
            </el-menu>
        </div>
    </transition>
</template>

<script setup name="MainSidebar">
import Logo from '../Logo/index.vue'
import SidebarItem from '../SidebarItem/index.vue'

import { useSettingsStore } from '@/store/modules/settings'
const settingsStore = useSettingsStore()
import { useMenuStore } from '@/store/modules/menu'
const menuStore = useMenuStore()

const switchMenu = inject('switchMenu')
</script>

<style lang="scss" scoped>
// 主侧边栏动画
.main-sidebar-enter-active {
    transition: 0.3s;
}
.main-sidebar-enter-from {
    transform: translateX(calc(var(--g-main-sidebar-width) * -1));
}
.main-sidebar-container {
    overflow-x: hidden;
    overflow-y: auto;
    overscroll-behavior: contain;
    // firefox隐藏滚动条
    scrollbar-width: none;
    // chrome隐藏滚动条
    &::-webkit-scrollbar {
        display: none;
    }

    position: relative;
    z-index: 1;
    width: var(--g-main-sidebar-width);
    @include themeify {
        color: themed("g-main-sidebar-menu-color");
        background-color: themed("g-main-sidebar-bg");
    }
    .sidebar-logo {
        transition: 0.3s;
        @include themeify {
            background-color: themed("g-main-sidebar-bg");
        }
    }
    .nav {
        width: inherit;
        padding-top: $g-sidebar-logo-height;
        .item {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            text-align: center;
            height: 60px;
            padding: 0 5px;
            cursor: pointer;
            transition: all 0.3s;
            &:hover {
                @include themeify {
                    color: themed("g-main-sidebar-menu-hover-color");
                    background-color: themed("g-main-sidebar-menu-hover-bg");
                }
            }
            &.active {
                @include themeify {
                    color: themed("g-main-sidebar-menu-active-color");
                    background-color: themed("g-main-sidebar-menu-active-bg");
                }
            }
            .svg-icon {
                margin: 0 auto;
                font-size: 24px;
            }
            span {
                text-align: center;
                font-size: 14px;
                @include text-overflow(1, false);
            }
        }
        &.nav-radius {
            .item {
                border-radius: 5px;
                margin: 0 5px 5px;
                &:last-child {
                    margin-bottom: 0;
                }
            }
        }
        &.nav-arrow {
            .item {
                position: relative;
                &.active::before {
                    content: "";
                    position: absolute;
                    right: 0;
                    top: 50%;
                    margin-top: -7px;
                    width: 0;
                    height: 0;
                    border-top: 7px solid transparent;
                    border-bottom: 7px solid transparent;
                    @include themeify {
                        border-right: 7px solid themed("g-sub-sidebar-bg");
                    }
                }
            }
        }
    }
    .el-menu-nav {
        padding-top: $g-sidebar-logo-height;
        border-right: none;
        background-color: inherit;
        width: initial;
        :deep(.el-sub-menu.is-active) {
            .el-sub-menu__title {
                @include themeify {
                    color: themed("g-main-sidebar-menu-active-color") !important;
                    background-color: themed("g-main-sidebar-menu-active-bg") !important;
                }
            }
        }
        :deep(.el-sub-menu__title) {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            text-align: center;
            height: 60px;
            line-height: initial;
            transition: all 0.3s;
            @include themeify {
                color: themed("g-main-sidebar-menu-color") !important;
            }
            &:hover {
                @include themeify {
                    color: themed("g-main-sidebar-menu-hover-color") !important;
                    background-color: themed("g-main-sidebar-menu-hover-bg") !important;
                }
                .icon {
                    transform: scale(1);
                }
            }
            .svg-icon {
                width: initial;
                margin-right: 0;
                font-size: 24px;
                vertical-align: middle;
                color: inherit;
            }
            .title {
                flex: initial;
                margin-left: initial;
                height: initial;
                line-height: initial;
                text-align: center;
                font-size: 14px;
                @include text-overflow(1, false);
            }
            .el-sub-menu__icon-arrow {
                display: none;
            }
        }
        &.el-menu-nav-radius {
            .sidebar-item {
                :deep(.el-sub-menu__title) {
                    border-radius: 5px;
                    margin: 0 5px 5px;
                }
                &:last-child {
                    margin-bottom: 0;
                }
            }
        }
        &.el-menu-nav-arrow {
            .sidebar-item {
                :deep(.is-active) {
                    .el-sub-menu__title {
                        &::before {
                            content: "";
                            position: absolute;
                            right: 0;
                            top: 50%;
                            margin-top: -7px;
                            width: 0;
                            height: 0;
                            border-top: 7px solid transparent;
                            border-bottom: 7px solid transparent;
                            border-right: 7px solid #fff;
                        }
                    }
                }
            }
        }
    }
}
</style>
