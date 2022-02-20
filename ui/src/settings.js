let globalSettings = {
    // 应用
    app: {
        /**
         * 主题
         * default 默认
         * vue-cli Vue CLI 风格
         * gitee 码云风格
         * freshness 清新
         * elegant 素雅
         * pure-white 纯白
         */
        theme: 'default',
        // Element 组件默认尺寸，支持：large、default、small
        elementSize: 'default',
        // 默认语言，留空则跟随系统
        defaultLang: '',
        /**
         * 是否开启权限功能，权限功能提供以下鉴权支持：
         * 1、鉴权组件：<Auth></Auth>、<AuthAll></AuthAll>
         * 2、鉴权指令：v-auth、v-auth-all
         * 3、鉴权函数：this.$auth()、this.$authAll()
         */
        enablePermission: false,
        // 是否开启后端返回导航数据
        enableBackendReturnMenu: false,
        // localStorage sessionStorage 前缀
        storagePrefix: 'osa_',
        // 是否开启页面水印
        enableWatermark: false,
        // 是否在非开发环境开启错误日志功能，具体业务代码在 ./util/error.log.js
        enableErrorLog: false
    },
    // 导航栏
    menu: {
        /**
         * 导航栏模式
         * side 侧边栏模式（含主导航）
         * head 顶部模式
         * single 侧边栏模式（无主导航）
         * only-side 侧边栏精简模式
         * only-head 顶部精简模式
         */
        menuMode: 'side',
        /**
          * 导航栏风格
          * card 卡片
          * radius 圆角
          * arrow 箭头
          */
        menuStyle: 'card',
        // 切换主导航同时打开窗口
        switchMainMenuAndOpenWindow: false,
        // 次导航只保持一个子项的展开
        subMenuUniqueOpened: true,
        // 侧边栏是否收起
        subMenuCollapse: false
    },
    // 顶栏
    topbar: {
        // 是否开启侧边栏展开收起按钮
        enableSidebarCollapse: false,
        // 是否开启导航搜索
        enableNavSearch: true,
        // 是否开启通知中心
        enableNotification: false,
        // 是否开启国际化
        enableI18n: false,
        // 是否开启全屏
        enableFullscreen: false,
        // 是否开启应用配置（建议在生产环境关闭）
        enableAppSetting: true
    },
    // 窗口
    window: {
        /**
         * 滚动后窗口自动定位
         * none 关闭
         * start 左侧
         * center 居中
         * end 右侧
         */
        autoPosition: 'none'
    },
    // 底部版权
    copyright: {
        // 是否开启
        enable: true,
        // 版权信息配置，格式为：Copyright © [dates] <company>, All Rights Reserved
        dates: '2021-2022',
        company: 'One-step-admin',
        website: 'https://hooray.github.io/one-step-admin'
    }
}

import settingsCustom from './settings.custom.json'
Object.assign(globalSettings, settingsCustom)

// 演示&开发环境开启全部功能（这部分代码可删除，仅方便作者打包演示环境）
if (import.meta.env.VITE_APP_MODE === 'example' || import.meta.env.MODE === 'development') {
    globalSettings.app.enablePermission = true
    globalSettings.app.enableErrorLog = true
    globalSettings.menu.menuStyle = 'arrow'
    globalSettings.topbar.enableSidebarCollapse = true
    globalSettings.topbar.enableNotification = true
    globalSettings.topbar.enableI18n = true
    globalSettings.topbar.enableFullscreen = true
}

export default globalSettings
