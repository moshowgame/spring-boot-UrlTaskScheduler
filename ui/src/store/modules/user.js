import { defineStore } from 'pinia'
import { piniaStore } from '@/store'
import storage from '@/util/storage'
import api from '@/api'

import { useMenuStore } from './menu'
import { useWindowStore } from './window'

export const useUserStore = defineStore(
    // 唯一ID
    'user',
    {
        state: () => ({
            account: storage.local.get('account') || '',
            token: storage.local.get('token') || '',
            failure_time: storage.local.get('failure_time') || '',
            permissions: []
        }),
        getters: {
            isLogin: state => {
                let retn = false
                if (state.token) {
                    if (new Date().getTime() < state.failure_time * 1000) {
                        retn = true
                    }
                }
                return retn
            }
        },
        actions: {
            login(data) {
                return new Promise((resolve, reject) => {
                    // 通过 mock 进行登录
                    api.post('member/login', data, {
                        baseURL: '/mock/'
                    }).then(res => {
                        storage.local.set('account', res.data.account)
                        storage.local.set('token', res.data.token)
                        storage.local.set('failure_time', res.data.failure_time)
                        this.account = res.data.account
                        this.token = res.data.token
                        this.failure_time = res.data.failure_time
                        resolve()
                    }).catch(error => {
                        reject(error)
                    })
                })
            },
            logout() {
                return new Promise(resolve => {
                    const menuStore = useMenuStore()
                    const windowStore = useWindowStore()
                    storage.local.remove('account')
                    storage.local.remove('token')
                    storage.local.remove('failure_time')
                    this.account = ''
                    this.token = ''
                    this.failure_time = ''
                    menuStore.switchHeaderActived(0)
                    menuStore.removeMenus()
                    windowStore.removeAll()
                    resolve()
                })
            },
            // 获取我的权限
            getPermissions() {
                return new Promise(resolve => {
                    // 通过 mock 获取权限
                    api.get('member/permission', {
                        baseURL: '/mock/',
                        params: {
                            account: this.account
                        }
                    }).then(res => {
                        this.permissions = res.data.permissions
                        resolve(res.data.permissions)
                    })
                })
            }
        }
    }
)

export function useUserOutsideStore() {
    return useUserStore(piniaStore)
}
