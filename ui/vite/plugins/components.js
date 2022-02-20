import components from 'unplugin-vue-components/vite'
import IconsResolver from 'unplugin-icons/resolver'

export default function createComponents() {
    return components({
        resolvers: IconsResolver(),
        dirs: ['src/components']
    })
}
