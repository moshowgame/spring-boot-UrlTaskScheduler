const path = require('path')

module.exports = {
    description: '创建标准窗口',
    prompts: [
        {
            type: 'input',
            name: 'name',
            message: '请输入窗口组件名称',
            validate: v => {
                if (!v || v.trim === '') {
                    return '窗口组件名称不能为空'
                } else {
                    return true
                }
            }
        },
        {
            type: 'input',
            name: 'cname',
            message: '请输入模块中文名称',
            default: '默认模块'
        },
        {
            type: 'confirm',
            name: 'isMock',
            message: '是否生成 Mock'
        }
    ],
    actions: data => {
        const actions = [
            {
                type: 'add',
                path: 'src/views/windows/{{properCase name}}/index.vue',
                templateFile: 'plop-templates/module/index.hbs'
            },
            {
                type: 'add',
                path: 'src/views/windows/{{properCase name}}/components/DetailForm/index.vue',
                templateFile: 'plop-templates/module/form.hbs'
            },
            {
                type: 'add',
                path: 'src/views/windows/{{properCase name}}/components/FormMode/index.vue',
                templateFile: 'plop-templates/module/mode.hbs'
            }
        ]
        if (data.isMock) {
            actions.push({
                type: 'add',
                path: 'src/mock/{{kebabCase name}}.js',
                templateFile: 'plop-templates/module/mock.hbs'
            })
        }
        return actions
    }
}
