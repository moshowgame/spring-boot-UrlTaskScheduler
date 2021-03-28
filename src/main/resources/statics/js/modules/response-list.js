$(function () {
    $("#jqGrid").jqGrid({
        mtype : 'POST',
        url: baseURL + 'urlTask/response/list?id='+$("#id").val(),
        datatype: "json",
        colModel: [			
			{ label: '响应ID', name: 'responseId', width: 80, key: true },
			{ label: '请求ID', name: 'requestId', width: 80, key: true },
            { label: '请求时间', name: 'responseTime',  width: 85 , formatter:function (value) {
                    return value;//formatDate(value);
                }},
			{ label: '响应报文', name: 'responseText', width: 400 }
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
        object: {}
    },
    methods: {
        query: function () {
            vm.reload();
        },
        reload: function () {
            vm.showList = true;
            const page = $("#jqGrid").jqGrid('getGridParam', 'page');
            $("#jqGrid").jqGrid('setGridParam', {
                postData: {'search': vm.q.search},
                page: page
            }).trigger("reloadGrid");
        },
    }
});