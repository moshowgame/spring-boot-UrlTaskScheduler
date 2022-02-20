import { defineStore } from 'pinia'
import { piniaStore } from '@/store'

import { useMenuStore } from './menu'

export const useWindowStore = defineStore(
    // 唯一ID
    'windows',
    {
        state: () => ({
            list: []
        }),
        actions: {
            add(data) {
                let preData
                if (typeof data === 'string') {
                    const menuStore = useMenuStore()
                    preData = {
                        name: data,
                        title: menuStore.flatMenu[data]?.title ?? '',
                        i18n: menuStore.flatMenu[data]?.i18n ?? null,
                        showTitle: menuStore.flatMenu[data]?.showTitle ?? null,
                        isMaximize: false,
                        params: menuStore.flatMenu[data]?.params ?? null,
                        breadcrumbNeste: menuStore.flatMenu[data]?.breadcrumbNeste ?? [],
                        reload: false
                    }
                } else {
                    preData = {
                        name: data.name,
                        title: data.title,
                        i18n: data.i18n ?? null,
                        showTitle: data.showTitle ?? null,
                        isMaximize: false,
                        params: data.params ?? null,
                        breadcrumbNeste: [],
                        reload: false
                    }
                }
                // 无则添加，有则更新
                let index = this.list.findIndex(item => item.name === preData.name)
                if (index < 0) {
                    this.list.push(preData)
                } else {
                    Object.assign(this.list[index], preData)
                }
            },
            remove(name) {
                this.list = this.list.filter(item => item.name !== name)
            },
            removeOtherSide(name) {
                this.list = this.list.filter(item => item.name === name)
            },
            removeLeftSide(name) {
                // 查找指定路由对应在标签页列表里的下标
                let index = ~~Object.keys(this.list).find(i => {
                    return this.list[i].name == name
                })
                this.list = this.list.filter((item, i) => {
                    return i >= index
                })
            },
            removeRightSide(name) {
                // 查找指定路由对应在标签页列表里的下标
                let index = ~~Object.keys(this.list).find(i => {
                    return this.list[i].name == name
                })
                this.list = this.list.filter((item, i) => {
                    return i <= index
                })
            },
            removeAll() {
                this.list = []
            },
            sort(data) {
                this.list = data
            },
            toggleMaximize(name) {
                this.list.map(item => {
                    if (item.name === name) {
                        item.isMaximize = !item.isMaximize
                    } else {
                        item.isMaximize = false
                    }
                })
            },
            allMinimize() {
                this.list.some(item => {
                    item.isMaximize = false
                })
            },
            reload(name) {
                this.list.map(item => {
                    if (item.name === name) {
                        item.reload = !item.reload
                    }
                })
            }
        }
    }
)

export function useWindowOutsideStore() {
    return useWindowStore(piniaStore)
}
