$(function () {
    $("#jqGrid").jqGrid({
        mtype : 'POST',
        url: baseURL + 'urlPlus/token/list?',
        datatype: "json",
        ajaxGridOptions: { contentType: "application/json" },
        serializeGridData: function (data) { return JSON.stringify(data); },
        colModel: [
            { label: '请求ID', name: 'requestId', width: 80, key: true },
            { label: '令牌URL', name: 'tokenUrl', width: 200 },
            { label: '请求属性', name: 'method', width: 80 },
            { label: '令牌参数', name: 'param', width: 100 },
            { label: '追加方式', name: 'appendType', width: 100 },
            { label: '追加参数', name: 'appendName', width: 100 },
            { label: '令牌解析', name: 'tokenExpression', width: 100 }
        ],
        viewrecords: true,
        height: 700,
        rowNum: 20,
        rowList : [20,100],
        rownumbers: true,
        rownumWidth: 25,
        autowidth:true,
        multiselect: false,
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