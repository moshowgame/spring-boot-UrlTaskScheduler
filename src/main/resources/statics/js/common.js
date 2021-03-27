//jqGrid的配置信息
$.jgrid.defaults.width = 1000;
$.jgrid.defaults.responsive = true;
$.jgrid.defaults.styleUI = 'Bootstrap4';

var baseURL = "../";

//工具集合Tools
window.T = {};

// 获取请求参数
// 使用示例
// location.href = http://localhost:8080/index.html?id=123
// T.p('id') --> 123;
const url = function (name) {
	const reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	const r = window.location.search.substr(1).match(reg);
	if (r != null) return unescape(r[2]);
	return null;
};
T.p = url;

//全局配置
$.ajaxSetup({
	dataType: "json",
	cache: false
});

//重写alert
window.alert = function(msg, callback){
	//重写为msg而不是alert
	parent.layer.msg(msg, {icon: 6});
}
window.error = function(msg, callback){
	//重写为msg而不是alert
	parent.layer.msg(msg, {icon: 5});
}
//重写confirm式样框
window.confirm = function(msg, callback){
	parent.layer.confirm(msg, {btn: ['确定','取消']},
	function(){//确定事件
		if(typeof(callback) === "function"){
			callback("ok");
		}
	});
}

//选择一条记录
function getSelectedRow() {
	const grid = $("#jqGrid");
	const rowKey = grid.getGridParam("selrow");
	if(!rowKey){
		error("请选择一条记录");
		return ;
	}

	const selectedIDs = grid.getGridParam("selarrrow");
	if(selectedIDs.length > 1){
		error("只能选择一条记录");
		return ;
	}

	return selectedIDs[0];
}

//选择多条记录
function getSelectedRows() {
	const grid = $("#jqGrid");
	const rowKey = grid.getGridParam("selrow");
	if(!rowKey){
		error("请选择一条记录");
		return ;
	}

	return grid.getGridParam("selarrrow");
}

//判断是否为空
function isBlank(value) {
	return !value || !/\S/.test(value)
}

//vue/js封装时间戳到日期格式化
function formatDate(timestamp) {
	const ts = parseInt(timestamp);
	const d = new Date(ts);
	const date = (d.getFullYear()) + "-" +
		(d.getMonth() + 1) + "-" +
		(d.getDate()) + " " +
		(d.getHours()) + ":" +
		(d.getMinutes()) + ":" +
		(d.getSeconds());
	return date;
}