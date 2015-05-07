if ($.fn.pagination){
	$.fn.pagination.defaults.beforePageText = '第';
	$.fn.pagination.defaults.afterPageText = '共{pages}页';
	$.fn.pagination.defaults.displayMsg = '显示{from}到{to},共{total}记录';
}
if ($.fn.datagrid){
	$.fn.datagrid.defaults.loadMsg = '正在处理，请稍待。。。';
	$.fn.datagrid.defaults.loadMsg
}
if ($.fn.treegrid && $.fn.datagrid){
	$.fn.treegrid.defaults.loadMsg = $.fn.datagrid.defaults.loadMsg;
}
if ($.messager){
	$.messager.defaults.ok = '确定';
	$.messager.defaults.cancel = '取消';
}
if ($.fn.validatebox){
	$.fn.validatebox.defaults.missingMessage = '该输入项为必输项';
	$.fn.validatebox.defaults.rules.email.message = '请输入有效的电子邮件地址';
	$.fn.validatebox.defaults.rules.url.message = '请输入有效的URL地址';
	$.fn.validatebox.defaults.rules.length.message = '输入内容长度必须介于{0}和{1}之间';
	$.fn.validatebox.defaults.rules.remote.message = '请修正该字段';
}
if ($.fn.numberbox){
	$.fn.numberbox.defaults.missingMessage = '该输入项为必输项';
}
if ($.fn.combobox){
	$.fn.combobox.defaults.missingMessage = '该输入项为必输项';
}
if ($.fn.combotree){
	$.fn.combotree.defaults.missingMessage = '该输入项为必输项';
}
if ($.fn.combogrid){
	$.fn.combogrid.defaults.missingMessage = '该输入项为必输项';
}
if ($.fn.calendar){
	$.fn.calendar.defaults.weeks = ['日','一','二','三','四','五','六'];
	$.fn.calendar.defaults.months = ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'];
}
if ($.fn.datebox){
	$.fn.datebox.defaults.currentText = '今天';
	$.fn.datebox.defaults.closeText = '关闭';
	$.fn.datebox.defaults.okText = '确定';
	$.fn.datebox.defaults.missingMessage = '该输入项为必输项';
	$.fn.datebox.defaults.formatter = function(date){
		var y = date.getFullYear();
		var m = date.getMonth()+1;
		var d = date.getDate();
		return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
	};
	$.fn.datebox.defaults.parser = function(s){
		if (!s) return new Date();
		var ss = s.split('-');
		var y = parseInt(ss[0],10);
		var m = parseInt(ss[1],10);
		var d = parseInt(ss[2],10);
		if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
			return new Date(y,m-1,d);
		} else {
			return new Date();
		}
	};
}
if ($.fn.datetimebox && $.fn.datebox){
	$.extend($.fn.datetimebox.defaults,{
		currentText: $.fn.datebox.defaults.currentText,
		closeText: $.fn.datebox.defaults.closeText,
		okText: $.fn.datebox.defaults.okText,
		missingMessage: $.fn.datebox.defaults.missingMessage
	});
}
$.extend($.fn.validatebox.defaults.rules, {
	checkMemberName: {
        validator: function(value, param){
            $.ajax({
            	url:"member_checkNameExist.action?username="+value,
            	success:function(data){
            	return !Boolean.valueOf(data);
			}});
        },
        message: '该用户名已被占用'
    },
	minLength: {
        validator: function(value, param){
            return value.length >= param[0];
        },
        message: '长度不能小于{0}个字符'
    },
	maxLength: {
        validator: function(value, param){
            return value.length <= param[0];
        },
        message: '长度不能大于{0}个字符'
    },    
	fixedLength: {
        validator: function(value, param){
            return value.length == param[0];
        },
        message: '长度为{0}个字符'
    },
    CHS : {
		validator : function(value, param) {
			return /^[\u0391-\uFFE5]+$/.test(value);
		},
		message : '请输入汉字'
	},
	ZIP : {
		validator : function(value, param) {
			return /^[1-9]\d{5}$/.test(value);
		},
		message : '邮政编码不存在'
	},
	QQ : {
		validator : function(value, param) {
			return /^[1-9]\d{4,10}$/.test(value);
		},
		message : 'QQ号码不正确'
	},
	mobile : {
		validator : function(value, param) {
			return /^1[3,5,8][0-9]{9}$/.test(value);
		},
		message : '手机号码不正确'
	},
	number : {
		validator : function(value, param) {
			return /^[\+]?\d+(\.\d+)?$/.test(value);
		},
		message : '请输入正数'
	},
	username : {
		validator : function(value, param) {
			return /^[\u0391-\uFFE5\w]{3,20}$/.test(value);
		},
		message : '3到20个字符，只允许使用：英文字母、下划线、中划线、数字'
	},
	password : {
		validator : function(value, param) {
			return !(/^(([A-Z]*|[a-z]*|\d*|[-_\~!@#\$%\^&\*\.\(\)\[\]\{\}<>\?\\\/\'\"]*)|.{0,5})$|\s/
					.test(value));
		},
		message : '密码由字母和数字组成，至少6位'
	},
	equals : {
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '两次输入的字符不一致'
	},
	confirmPassword : {
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '密码不一致'
	},
	digits : {
		validator : function(value, param) {
			return /^\d+$/.test(value);
		},
		message : '请输入整数'
	}
});