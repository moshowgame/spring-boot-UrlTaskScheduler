import { defineStore } from 'pinia'
import { piniaStore } from '@/store'
import settings from '@/settings'
import api from '@/api'

export const useSettingsStore = defineStore(
    // 唯一ID
    'settings',
    {
        state: () => ({
            ...settings,
            // 页面标题
            title: '',
            // 预览全部窗口
            previewAllWindows: false
        }),
        actions: {
            // 切换侧边栏导航展开/收起
            toggleSidebarCollapse() {
                this.menu.subMenuCollapse = !this.menu.subMenuCollapse
            },
            // 设置默认语言
            setDefaultLang(lang) {
                this.app.defaultLang = lang
                api.defaults.headers.common['Accept-Language'] = lang
            },
            // 更新主题配置
            updateThemeSetting(data) {
                Object.assign(this, data)
            }
        }
    }
)

export function useSettingsOutsideStore() {
    return useSettingsStore(piniaStore)
}
