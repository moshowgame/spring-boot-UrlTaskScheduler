import vue from '@vitejs/plugin-vue'

import createRestart from './restart'
import createHtml from './html'
import createAutoImport from './auto-import'
import createComponents from './components'
import createSetupExtend from './setup-extend'
import createSvgIcon from './svg-icon'
import createI18n from './i18n'
import createIcons from './icons'
import createMock from './mock'
import createCompression from './compression'
import createSpritesmith from './spritesmith'
import createBanner from './banner'
import createPwa from './pwa'

export default function createVitePlugins(viteEnv, isBuild = false) {
    const vitePlugins = [vue()]
    !isBuild && vitePlugins.push(createRestart())
    vitePlugins.push(createHtml(viteEnv, isBuild))
    vitePlugins.push(createAutoImport())
    vitePlugins.push(createComponents())
    vitePlugins.push(createSetupExtend())
    vitePlugins.push(createSvgIcon(isBuild))
    vitePlugins.push(createI18n())
    vitePlugins.push(createIcons())
    vitePlugins.push(createMock())
    isBuild && vitePlugins.push(...createCompression(viteEnv))
    vitePlugins.push(...createSpritesmith(isBuild))
    vitePlugins.push(createBanner())
    isBuild && viteEnv.VITE_BUILD_PWA == 'true' && vitePlugins.push(createPwa())
    return vitePlugins
}
