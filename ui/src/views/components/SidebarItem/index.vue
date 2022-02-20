<template>
    <div class="sidebar-item">
        <el-menu-item v-if="!item.children" :title="generateI18nTitle(item.i18n, item.title)" :index="JSON.stringify(item)" @click="handleOpen(item.windowName)">
            <svg-icon v-if="item.icon" :name="item.icon" />
            <span class="title">{{ generateI18nTitle(item.i18n, item.title) }}</span>
            <span
                v-if="badge(item.badge).visible" :class="{
                    'badge': true,
                    'badge-dot': badge(item.badge).type === 'dot',
                    'badge-text': badge(item.badge).type === 'text'
                }"
            >{{ badge(item.badge).type === 'text' ? badge(item.badge).value : '' }}</span>
        </el-menu-item>
        <el-sub-menu v-else :title="generateI18nTitle(item.i18n, item.title)" :index="JSON.stringify(item)">
            <template #title>
                <svg-icon v-if="item.icon" :name="item.icon" />
                <span class="title">{{ generateI18nTitle(item.i18n, item.title) }}</span>
                <span
                    v-if="badge(item.badge).visible" :class="{
                        'badge': true,
                        'badge-dot': badge(item.badge).type === 'dot',
                        'badge-text': badge(item.badge).type === 'text'
                    }"
                >{{ badge(item.badge).type === 'text' ? badge(item.badge).value : '' }}</span>
            </template>
            <SidebarItem v-for="route in item.children" :key="route.path" :item="route" />
        </el-sub-menu>
    </div>
</template>

<script setup name="SidebarItem">
import SidebarItem from './index.vue'

const { proxy } = getCurrentInstance()

defineProps({
    item: {
        type: Object,
        required: true
    }
})

const generateI18nTitle = inject('generateI18nTitle')

function badge(badge) {
    let res = {
        type: '', // text or dot
        value: '',
        visible: false
    }
    if (badge) {
        res.visible = true
        res.value = typeof badge == 'function' ? badge() : badge
        if (typeof res.value == 'boolean') {
            res.type = 'dot'
            if (!res.value) {
                res.visible = false
            }
        } else if (typeof res.value == 'number') {
            res.type = 'text'
            if (res.value <= 0) {
                res.visible = false
            }
        } else {
            res.type = 'text'
            if (!res.value) {
                res.visible = false
            }
        }
    }
    return res
}

function handleOpen(windowName) {
    if (/^(https?:|mailto:|tel:)/.test(windowName)) {
        window.open(windowName)
    } else {
        proxy.$window.add(windowName)
    }
}
</script>

<style lang="scss" scoped>
:deep(.el-menu-item),
:deep(.el-menu-item span.title),
:deep(.el-sub-menu__title),
:deep(.el-sub-menu__title span.title) {
    flex: 1;
    vertical-align: inherit;
    @include text-overflow;
}
:deep(.el-menu-item),
:deep(.el-sub-menu__title) {
    display: flex;
    align-items: center;
}
:deep(.el-sub-menu),
:deep(.el-menu-item) {
    .svg-icon {
        width: 20px;
        font-size: 20px;
        vertical-align: -0.25em;
        transition: transform 0.3s;
        color: unset;
        &[class^="el-icon-"],
        &[class*=" el-icon-"] {
            vertical-align: middle;
        }
    }
    .svg-icon + .title {
        margin-left: 10px;
    }
    &:hover > .svg-icon,
    .el-sub-menu__title:hover > .svg-icon {
        transform: scale(1.2);
    }
}
a {
    cursor: pointer;
    color: inherit;
    text-decoration: none;
}
.badge {
    position: absolute;
    z-index: 1;
    @include themeify {
        background-color: themed("g-badge-bg");
        box-shadow: 0 0 0 1px themed("g-badge-border-color");
    }
    @include position-center(y);
    &-dot {
        right: 15px;
        border-radius: 50%;
        width: 6px;
        height: 6px;
        &::after {
            content: "";
            pointer-events: none;
            position: absolute;
            top: 0;
            display: block;
            width: 6px;
            height: 6px;
            border-radius: 50%;
            animation: dot-twinkling 1s infinite ease-in-out;
            @include themeify {
                background-color: themed("g-badge-bg");
            }
        }
    }
    @keyframes dot-twinkling {
        0% {
            opacity: 0.6;
            transform: scale(0.8);
        }
        100% {
            opacity: 0;
            transform: scale(2.4);
        }
    }
    &-text {
        right: 15px;
        border-radius: 10px;
        font-size: 12px;
        height: 18px;
        line-height: 18px;
        padding: 0 6px;
        text-align: center;
        white-space: nowrap;
        @include themeify {
            color: themed("g-badge-color");
        }
    }
}
.el-sub-menu__title {
    > .badge {
        &-dot {
            right: 40px;
        }
        &-text {
            right: 40px;
        }
    }
}
</style>
