<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=BaseAction.rootLocation %>/"/>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<title>无标题文档</title>
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"  />
		<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css" />
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css"/>
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				initTip();
				$(".uploadFile").each(function(){
					initUploadify($(this).attr("id").replace("file",""));
				});
			});
			function initUploadify(id){
				$("#file"+id).uploadify( {
					'auto'				: true, //是否自动开始 默认true
					'multi'				: false, //是否支持多文件上传 默认true
					'formData'			: {'module':'pb','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
					'uploader'			: "<%=uploadPath %>core/upload.action",//文件服务器路径
					'swf'				: uploadify.swf,//上传组件swf
					'width'				: uploadify.width,//按钮图片的长度
					'height'			: uploadify.height,//按钮图片的高度
					'buttonText'		: uploadify.buttonText, //按钮上的文字
					'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
					'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
					'removeTimeout'		: uploadify.removeTimeout, //上传完成移除出队列 默认true
					'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
					'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
					'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
					'onUploadSuccess'	: function(file, data, response) {//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
						$("#photo"+id).val($.parseJSON(data).path);
					}
				});
			}
			function save(id){
				if(notNull("name"+id,"楼层名称")){
					var url = "<%=basePath%>floor!save.action";
					var data = {"floor.name":$("#name"+id).val(),"floor.photo":$("#photo"+id).val(),"floor.buildingId":$("#buildingId"+id).val(),"floor.orderNo":$("#orderNo"+id).val()};
					$.post(url,data,function(data){
						showTip(data.result.msg,2000);
						if(data.result.success){
							var tr = $("#tr"+id);
							tr.find("input").each(function(){
								$(this).attr("id",$(this).attr("id").replace(id,data.result.value.id));
							});
							tr.find("img").each(function(){
								$(this).attr("id",$(this).attr("id").replace(id,data.result.value.id));
							});
							tr.attr("id",tr.attr("id").replace(id,data.result.value.id));
						}
					});
				}
			}
			function update(id){
				if(notNull("name"+id,"楼层名称")){
					var url = "<%=basePath%>floor!update.action";
					var data = {"floor.name":$("#name"+id).val(),"floor.photo":$("#photo"+id).val(),"floor.id":$("#id"+id).val()};
					$.post(url,data,function(data){
						showTip(data.result.msg,2000);
					});
				}
			}
			function moveUp(id){
				var moveTr = $("#tr"+id);
				var staticTr = moveTr.prev();
				if(staticTr.html()!=null){
					var temp = moveTr.find(".orderNo").get(0).value;
					moveTr.find(".orderNo").get(0).value=staticTr.find(".orderNo").get(0).value;
					staticTr.find(".orderNo").get(0).value=temp;
					$.post("<%=basePath%>floor!exchangeOrder.action?ids="+id+","+staticTr.attr("id").replace("tr",""),function(data){
						if(data.result.success){
							moveTr.insertBefore(staticTr);
						} else {
							showTip(data.result.msg,2000);
						}
					});
				}
			}
			function moveDown(id){
				var moveTr = $("#tr"+id);
				var staticTr = moveTr.next();
				if(staticTr.html()!=null){
					var temp = moveTr.find(".orderNo").get(0).value;
					moveTr.find(".orderNo").get(0).value=staticTr.find(".orderNo").get(0).value;
					staticTr.find(".orderNo").get(0).value=temp;
					$.post("<%=basePath%>floor!exchangeOrder.action?ids="+id+","+staticTr.attr("id").replace("tr",""),function(data){
						if(data.result.success){
							moveTr.insertAfter(staticTr);
						} else {
							showTip(data.result.msg,2000);
						}
					});
				}
			}
			function remove(id){
				$.post("<%=basePath%>floor!delete.action?id="+id,function(data){
					showTip(data.result.msg,2000);
					if(data.result.success){
						location.reload();
					}
				});
			}
			function showPhoto(id){
				var path = $("#photo"+id).val();
				if(path==''){
					showTip("该楼层未上传图片!",2000);
					return;
				}
				fbShow($("#photo"+id).val());
			}
			function create(){
				var id = new Date().getTime();
				var tr = $("<tr id=\"tr"+id+"\"></tr>");
				var orderNo = 1;
				if($(".orderNo").last().val()){
					orderNo = parseInt($(".orderNo").last().val())+1;
				}
				tr.append($("<td class=\"layertdleft100\"></td>").append("楼层名称："));
				tr.append($("<td class=\"layerright\"></td>").append($("<input id=\"name"+id+"\" class=\"input100\" />")).append($("<input id=\"orderNo"+id+"\" value=\""+orderNo+"\" class=\"orderNo\" type=\"hidden\"/>")).append($("<input id=\"buildingId"+id+"\" value=\"${id}\" type=\"hidden\"/>")).append($("<input id=\"id"+id+"\" class=\"input100\" type=\"hidden\"/>")));
				tr.append($("<td class=\"layerright\"></td>").append($("<input id=\"file"+id+"\" class=\"input100\" />")).append($("<input id=\"photo"+id+"\" type=\"hidden\"/>")));
				tr.append($("<td class=\"layerright\"></td>").append($("<img />",{id:"save"+id,src:"<%=basePath %>web/images/pbseavebtn.gif",click:function(){
							save($(this).attr("id").replace("save",""));
						}})).append(" ").append($("<img />",{id:"showPhoto"+id,src:"<%=basePath %>web/images/pblookbtn.gif",click:function(){
							showPhoto($(this).attr("id").replace("showPhoto",""));
						}})).append(" ").append($("<img />",{id:"moveUp"+id,src:"<%=basePath %>web/images/pbmoveupbtn.gif",click:function(){
							moveUp($(this).attr("id").replace("moveUp",""));
						}})).append(" ").append($("<img />",{id:"moveDown"+id,src:"<%=basePath %>web/images/pbmovedown.gif",click:function(){
							moveDown($(this).attr("id").replace("moveDown",""));
						}})).append(" ").append($("<img />",{id:"remove"+id,src:"<%=basePath %>web/images/pbdelbtn.gif",click:function(){
							remove($(this).attr("id").replace("remove",""));
						}})));
				tr.appendTo($("#floorList"));
				initUploadify(id);
				parent.fb.resize();
			}
		</script>
	</head>

<body>
<form action="" method="post" name="form1" id="form1">
<div class="basediv">
	<div class="tip tip5_tip">自定义楼层，楼层名称建议使用一楼、二楼、地下一楼等，通过上移、下移调整楼层上下结构。</div>
	<div class="basediv">
		<div style="overflow-x:hidden; overflow-y:scroll; height:400px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" id="floorList">
				<c:forEach items="${result.value}" var="floor">
				<tr id="tr${floor.id}">
					<td class="layertdleft100">楼层名称：</td>
					<td class="layerright">
						<input id="id${floor.id}" type="hidden" class="input100" value="${floor.id}" />
						<input id="orderNo${floor.id}" type="hidden" class="orderNo" value="${floor.orderNo}" />
						<input id="name${floor.id}" type="text" class="input100" value="${floor.name}" />
					</td>
					<td class="layerright">
						<input id="file${floor.id}" class="uploadFile" type="file" />
						<input id="photo${floor.id}" type="hidden" value="${floor.photo}" />
					</td>
					<td class="layerrightpadding">
						<img id="save${floor.id}" src="<%=basePath %>web/images/pbseavebtn.gif" onclick="update($(this).attr('id').replace('save',''))"/>
						<img id="showPhoto${floor.id}" src="<%=basePath %>web/images/pblookbtn.gif" onclick="showPhoto($(this).attr('id').replace('showPhoto',''))"/>
						<img id="moveUp${floor.id}" src="<%=basePath %>web/images/pbmoveupbtn.gif" onclick="moveUp($(this).attr('id').replace('moveUp',''))"/>
						<img id="moveDown${floor.id}" src="<%=basePath %>web/images/pbmovedown.gif" onclick="moveDown($(this).attr('id').replace('moveDown',''))"/>
						<img id="remove${floor.id}" src="<%=basePath %>web/images/pbdelbtn.gif" onclick="remove($(this).attr('id').replace('remove',''))"/>
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
</div>
<div class="buttondiv">
	<a href="javascript:void(0)" title="" class="btn_bg" onclick="create()"><span><img src="core/common/images/building_floor_add.png">新建</span></a>
	<a href="javascript:void(0)" title="" class="btn_bg" onclick="parent.fb.end();"><span><img src="core/common/images/close.png">取消</span></a>
</div>
</form>
</body>
</html>
