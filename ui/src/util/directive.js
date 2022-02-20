import { auth, authAll } from '@/util'
import Waves from 'node-waves'
import 'node-waves/dist/waves.min.css'

export default function directive(app) {
    // 注册 v-auth 和 v-auth-all 指令
    app.directive('auth', {
        mounted: (el, binding) => {
            if (!auth(binding.value)) {
                el.remove()
            }
        }
    })
    app.directive('auth-all', {
        mounted: (el, binding) => {
            if (!authAll(binding.value)) {
                el.remove()
            }
        }
    })
    // 注册 Waves 指令
    app.directive('waves', {
        created: () => {
            Waves.init()
        },
        mounted: (el, binding) => {
            let classes = ['button', 'circle', 'block', 'float', 'light', 'classic'].filter(cls => binding.modifiers[cls]).map(cls => `waves-${cls}`)
            Waves.attach(el, classes)
        }
    })
}
