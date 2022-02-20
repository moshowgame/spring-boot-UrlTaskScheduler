import { defineAsyncComponent } from 'vue'

export default function registerWindowComponent(app) {
    const componentsContext = import.meta.glob('./*/index.vue')
    for (const path in componentsContext) {
        let name = path.replace('./', '')
        name = name.slice(0, name.indexOf('/'))
        app.component(name, defineAsyncComponent(componentsContext[path]))
    }
}
