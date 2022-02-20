import path from 'path'
import vueI18n from '@intlify/vite-plugin-vue-i18n'

export default function createI18n() {
    return vueI18n({
        compositionOnly: false,
        include: path.resolve(__dirname, '../../src/locales/lang/**')
    })
}
