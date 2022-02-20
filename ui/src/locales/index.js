import { useSettingsOutsideStore } from '@/store/modules/settings'

import { createI18n } from 'vue-i18n'
import messages from '@intlify/vite-plugin-vue-i18n/messages'

import elementLocaleZhCN from 'element-plus/lib/locale/lang/zh-cn'
import elementLocaleZhTW from 'element-plus/lib/locale/lang/zh-tw'
import elementLocaleEn from 'element-plus/lib/locale/lang/en'

function useI18n(app) {
    const settingsOutsideStore = useSettingsOutsideStore()
    // 如果没设置默认语言，则根据当前浏览器语言设置默认语言
    if (!settingsOutsideStore.app.defaultLang) {
        const lang = (navigator.language || navigator.browserLanguage).toLowerCase()
        for (var key in messages) {
            lang.includes(key) && settingsOutsideStore.setDefaultLang(key)
        }
    }
    const i18n = createI18n({
        legacy: true,
        locale: settingsOutsideStore.app.defaultLang,
        fallbackLocale: 'zh-cn',
        messages
    })
    app.use(i18n)
}

function getElementLocales() {
    let locales = {}
    for (const key in messages) {
        locales[key] = {}
        switch (key) {
            case 'zh-cn':
                Object.assign(locales[key], elementLocaleZhCN, { 'labelName': '中文(简体)' })
                break
            case 'zh-tw':
                Object.assign(locales[key], elementLocaleZhTW, { 'labelName': '中文(繁體)' })
                break
            case 'en':
                Object.assign(locales[key], elementLocaleEn, { 'labelName': 'English' })
                break
        }
    }
    return locales
}

export {
    useI18n,
    getElementLocales
}
