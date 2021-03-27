//生成菜单
const menuItem = Vue.extend({
	name: 'menu-item',
	props: {item: {}},
	template: [
		'<li>',
		'	<a v-if="item.type === 0" href="javascript:;">',
		'		<i v-if="item.icon != null" :class="item.icon"></i>',
		'		<span>{{item.name}}</span>',
		'		<i class="fa fa-angle-left pull-right"></i>',
		'	</a>',
		'	<ul v-if="item.type === 0" class="treeview-menu">',
		'		<menu-item :item="item" v-for="item in item.list"></menu-item>',
		'	</ul>',

		'	<a v-if="item.type === 1 && item.parentId === 0" :href="\'#\'+item.url">',
		'		<i v-if="item.icon != null" :class="item.icon"></i>',
		'		<span>{{item.name}}</span>',
		'	</a>',

		'	<a v-if="item.type === 1 && item.parentId != 0" :href="\'#\'+item.url"><i v-if="item.icon != null" :class="item.icon"></i><i v-else class="fa fa-circle-o"></i> {{item.name}}</a>',
		'</li>'
	].join('')
});
//注册菜单组件
Vue.component('menuItem',menuItem);

//iframe自适应
$(window).on('resize', function() {
	const $content = $('.content');
	$content.height($(this).height() - 200);
	$content.find('iframe').each(function() {
		$(this).height($content.height());
	});
}).resize();

const vm = new Vue({
	el: '#rrapp',
	data: {
		main: "request/list",
		menuList:[{"menuId":41,"parentId":0,"parentName":null,"name":"Request请求","url":"urlTask/list","perms":null,"type":1,"icon":"fa fa-file-code-o","orderNum":6,"open":null,"list":null},{"menuId":42,"parentId":0,"parentName":null,"name":"Token令牌","url":"urlPlus/token/list","perms":null,"type":1,"icon":"fa fa-file-code-o","orderNum":6,"open":null,"list":null},{"menuId":43,"parentId":0,"parentName":null,"name":"Log日志","url":"urlTask/log/list","perms":null,"type":1,"icon":"fa fa-file-code-o","orderNum":6,"open":null,"list":null}],
		// menuList:{"msg":"success","menuList":[{"menuId":41,"parentId":0,"parentName":null,"name":"Request请求","url":"urlTask/list","perms":null,"type":1,"icon":"fa fa-file-code-o","orderNum":6,"open":null,"list":null},{"menuId":42,"parentId":0,"parentName":null,"name":"Token令牌","url":"urlPlus/token/list","perms":null,"type":1,"icon":"fa fa-file-code-o","orderNum":6,"open":null,"list":null},{"menuId":43,"parentId":0,"parentName":null,"name":"Log日志","url":"urlTask/log/list","perms":null,"type":1,"icon":"fa fa-file-code-o","orderNum":6,"open":null,"list":null}],"code":0},
		navTitle:"控制台"
	},
	methods: {
		donate: function () {
		}
	},
	created: function () {

	},
	updated: function(){
		//路由
		const router = new Router();
		routerList(router, vm.menuList);
		router.start();
	}
});



function routerList(router, menuList){
	for(const key in menuList){
		const menu = menuList[key];
		if(menu.type == 0){
			routerList(router, menu.list);
		}else if(menu.type == 1){
			router.add('#'+menu.url, function() {
				const url = window.location.hash;

				//替换iframe的url
				vm.main = url.replace('#', '');

				//导航菜单展开
				$(".treeview-menu li").removeClass("active");
				$("a[href='"+url+"']").parents("li").addClass("active");

				vm.navTitle = $("a[href='"+url+"']").text();
			});
		}
	}
}
