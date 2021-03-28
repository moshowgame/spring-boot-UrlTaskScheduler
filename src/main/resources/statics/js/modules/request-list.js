$(function () {
    $("#jqGrid").jqGrid({
        mtype : 'POST',
        url: baseURL + 'urlTask/request/list',
        datatype: "json",
        colModel: [			
			{ label: '请求ID', name: 'requestId', width: 45, key: true },
			{ label: '请求名', name: 'requestName', width: 75 },
            { label: '请求方式', name: 'requestMethod', sortable: false, width: 75 },
			{ label: 'CRON表达式', name: 'requestCron', width: 90 },
			{ label: '手机号', name: 'requestUrl', width: 100 },
			{ label: '任务状态', name: 'status', width: 60, formatter: function(value, options, row){
				return value === 0 ? 
					'<span class="label label-danger">禁用</span>' : 
					'<span class="label label-success">启用</span>';
			}},
			{ label: '触发状态', name: 'triggerState', width: 60, formatter: function(value, options, row){
			    if(value === 'WAITING') {return '<span class="label label-info">等待执行中</span>' ;}
			    else if(value === 'PAUSED') {return '<span class="label label-info">任务暂停</span>' ;}
			    else if(value === 'ACQUIRED') {return '<span class="label label-info">正在执行中</span>' ;}
			    else if(value === 'BLOCKED') {return '<span class="label label-primary">任务阻塞</span>' ;}
			    else if(value === 'ERROR') {return '<span class="label label-error">任务错误</span>' ;}
				else{return '暂时无法获取';}
			}},
            { label: '超时设置', name: 'requestTimeout', width: 80 },
			{ label: '下次执行', name: 'nextFireTime',  width: 85 , formatter:function (value) {
                    return formatDate(value);
                }},
			{ label: '更新时间', name: 'updateTime', index: "update_time", width: 85}
        ],
		viewrecords: true,
        height: 600,
        rowNum: 10,
		rowList : [10,30,50],
        rownumbers: true, 
        rownumWidth: 25, 
        autowidth:true,
        multiselect: true,
        pager: "#jqGridPager",
        jsonReader : {
            root: "page.list",
            page: "page.currPage",
            total: "page.totalPage",
            records: "page.totalCount"
        },
        prmNames : {
            page:"page", 
            rows:"limit", 
            order: "order"
        },
        gridComplete:function(){
        	//隐藏grid底部滚动条
        	$("#jqGrid").closest(".ui-jqgrid-bdiv").css({ "overflow-x" : "hidden" }); 
        }
    });
});
const setting = {
    data: {
        simpleData: {
            enable: true,
            rootPId: -1
        },
        key: {
            url: "nourl"
        }
    }
};

const vm = new Vue({
    el: '#rrapp',
    data: {
        q: {
            search: null
        },
        showList: true,
        title: null,
        roleList: {},
        object: {}
    },
    methods: {
        query: function () {
            vm.reload();
        },
        add: function () {
            vm.showList = false;
            vm.title = "新增";
            vm.object = {};

        },
        update: function () {
            const objectId = getSelectedRow();
            if (objectId == null) {
                return;
            }

            vm.showList = false;
            vm.title = "修改";
            vm.getObject(objectId);
        },
        del: function () {
            const objectIds = getSelectedRow();
            if (objectIds == null) {
                return;
            }

            confirm('确定要删除选中的记录？', function () {
                $.ajax({
                    type: "POST",
                    url: baseURL + "urlTask/delete",
                    contentType: "application/json",
                    data: JSON.stringify({id: objectIds}),
                    success: function (r) {
                        if (r.code == 0) {
                            alert('操作成功');
                            vm.reload();
                        } else {
                            error(r.msg);
                        }
                    }
                });
            });
        },
        saveOrUpdate: function () {
            //const url = vm.object.objectId == null ? "urlTask/save" : "urlTask/update";
            $.ajax({
                type: "POST",
                url: baseURL + "urlTask/save",
                contentType: "application/json",
                data: JSON.stringify(vm.object),
                success: function (r) {
                    if (r.code === 0) {
                        alert('操作成功');
                        vm.reload();
                    } else {
                        error(r.msg);
                    }
                }
            });
        },
        getObject: function (objectId) {
            $.get(baseURL + "/urlTask/info?id=" + objectId, function (r) {
                vm.object = r.data;
            });
        },
        start: function () {
            const objectId = getSelectedRow();
            if (objectId == null) {
                return;
            }
            confirm('开始任务？', function () {
                $.post(baseURL + "/urlTask/start?requestId=" + objectId, function (r) {
                    if (r.code === 0) {
                        alert('操作成功');
                        vm.reload();
                    } else {
                        error(r.msg);
                    }
                });
            });
        },
        pause: function () {
            const objectId = getSelectedRow();
            if (objectId == null) {
                return;
            }
            confirm('暂停任务？', function () {
                $.post(baseURL + "/urlTask/pause?requestId=" + objectId, function (r) {
                    if (r.code === 0) {
                        alert('操作成功');
                        vm.reload();
                    } else {
                        error(r.msg);
                    }
                });
            });
        },
        resume: function () {
            const objectId = getSelectedRow();
            if (objectId == null) {
                return;
            }
            confirm('恢复任务？', function () {
                $.post(baseURL + "/urlTask/resume?requestId=" + objectId, function (r) {
                    if (r.code === 0) {
                        alert('操作成功');
                        vm.reload();
                    } else {
                        error(r.msg);
                    }
                });
            });
        },
        trigger: function () {
            const objectId = getSelectedRow();
            if (objectId == null) {
                return;
            }
            confirm('触发任务？', function () {
                $.post(baseURL + "/urlTask/trigger?requestId=" + objectId, function (r) {
                    if (r.code === 0) {
                        alert('操作成功');
                        vm.reload();
                    } else {
                        error(r.msg);
                    }
                });
            });
        },
        reload: function () {
            vm.showList = true;
            const page = $("#jqGrid").jqGrid('getGridParam', 'page');
            $("#jqGrid").jqGrid('setGridParam', {
                postData: {'search': vm.q.search},
                page: page
            }).trigger("reloadGrid");
        },
        response: function () {
            const objectId = getSelectedRow();
            if (objectId == null) {
                return;
            }
            window.open(baseURL + 'response/list?requestId=' + objectId, '日志查看', 'height=750, width=600, top=0,left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no')
        },
        token: function () {
            const objectId = getSelectedRow();
            if (objectId == null) {
                return;
            }
            window.open(baseURL + 'token/detail?requestId=' + objectId, 'TOKEN令牌设置', 'height=750, width=600, top=0,left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no')
        }
    }
});