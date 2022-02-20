import settings from '@/settings'

const storage = {
    local: {
        has: key => {
            return !!localStorage.getItem(`${settings.app.storagePrefix}${key}`)
        },
        get: key => {
            return localStorage.getItem(`${settings.app.storagePrefix}${key}`)
        },
        set: (key, value) => {
            localStorage.setItem(`${settings.app.storagePrefix}${key}`, value)
        },
        remove: key => {
            localStorage.removeItem(`${settings.app.storagePrefix}${key}`)
        },
        clear: () => {
            localStorage.clear()
        }
    },
    session: {
        has: key => {
            return !!sessionStorage.getItem(`${settings.app.storagePrefix}${key}`)
        },
        get: key => {
            return sessionStorage.getItem(`${settings.app.storagePrefix}${key}`)
        },
        set: (key, value) => {
            sessionStorage.setItem(`${settings.app.storagePrefix}${key}`, value)
        },
        remove: key => {
            sessionStorage.removeItem(`${settings.app.storagePrefix}${key}`)
        },
        clear: () => {
            sessionStorage.clear()
        }
    }
}

export default storage
