import Icons from 'unplugin-icons/vite'

export default function createIcons() {
    return Icons({
        autoInstall: true,
        scale: 1,
        defaultStyle: `
            vertical-align: -0.15em;
            fill: currentColor;
            overflow: hidden;
        `
    })
}
