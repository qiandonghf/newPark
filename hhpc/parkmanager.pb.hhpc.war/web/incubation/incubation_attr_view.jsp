<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=BaseAction.rootLocation %>/"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>无标题文档</title>
		
		<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/merchants.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
		<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
		
		<script type="text/javascript">
			$(function(){
				initTip();
				$('#investRight_height').css('height',getTabContentHeight());
				$('#investRight_height2').css('height',getTabContentHeight());
				$('#investRight_height3').css('height',getTabContentHeight()-33);
				initUploadify("report","上传","100");
				initUploadify("about","上传","100");
				initUploadify("legal","上传","100");
				initUploadify("list","上传","100");
				initUploadify("constitution","上传","100");
				initUploadify("identity","上传","100");
				initUploadify("license","上传","100");
				initUploadify("shareholder","上传","100");
				initUploadify("project","上传","100");
				initUploadify("other","上传","100");
				checkAtts();
			});
			
			function checkAtts(id){
				if(id){
					if($("#"+id).text().replace(/(^\s*)|(\s*$)/g, "") == ''){
						$("#"+id).parent().parent().hide();
					}
				}else{
					$(".investmentAtts").each(function(){
						if($(this).text().replace(/(^\s*)|(\s*$)/g, "") == ''){
							$(this).parent().parent().hide();
						}
					});
				}
			}
			
			function initUploadify(id,name,width){
				var root = '<%=BaseAction.rootLocation %>/';
				$("#"+id).uploadify( {
					'auto'				: true, //是否自动开始 默认true
					'multi'				: false, //是否支持多文件上传 默认true
					'formData'			: {'module':'pb','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
					'uploader'			: root+"upload.action",
					'swf'				: uploadify.swf,//上传组件swf
					'width'				: width,//按钮图片的长度
					'height'			: "20",//按钮图片的高度
					'buttonText'		: name,
					'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
					'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
					'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
					'fileTypeDesc'		: "*.*",//选择文件对话框文件类型描述信息
					'fileTypeExts'		: "*.*",//可上传上的文件类型
					'onUploadSuccess'	: function(file, data, response){
						onUploadSuccess(file, data, response,id);
					}
				});
			}
			
			function onUploadSuccess(file, data, response,cid) {
				var info = $.parseJSON(data);
				var path = info.path;
				var oldName = info.originalName;
				var subName = oldName;
				if(oldName.length >=16){
					subName = oldName.substring(0,15)+"...";
				}
				var size = info.size;
				var id= $("input[name='investment.id']").val();
				var type = cid.toUpperCase();
				var postData = {"investmentArchiveAtt.investmentId":id,"investmentArchiveAtt.name":oldName,"investmentArchiveAtt.newName":path,"investmentArchiveAtt.size":size,"investmentArchiveAtt.attType":type};
				$.ajax({
					type:"post",
					data:postData,
					url :"<%=basePath%>investment!attrUp.action",
					success:function(data){
						if(data.result.success){
							$("#"+cid+"Atts").html($("#"+cid+"Atts").html()+setText(path,oldName,size,id,subName));
							$("."+cid).show();
						}
					}
				});
			}
			
			function setText(path,oldName,size,id,subName){
				var htmlText = "";
				htmlText += "<div class=\'downlistleft\'>";
				htmlText +="<img src=\'core/common/images/word.png\'/>";
				htmlText +="<input type=\'hidden\' value=\'"+path+"\'/>";
				htmlText +="<input class=\'att"+id+"\' type=\'hidden\' value=\'"+oldName+"\'/>";
				htmlText +="<ul>";
				htmlText +="<li><em class=\'lititle att"+id+"\' title=\'"+oldName+"\'>"+subName+"</em><span>("+Math.round(size/1024)+"KB)</span>";
				htmlText +="</li><li>";
				htmlText +="<a href=\'javascript:void(0);\' onclick=\'downAttr(this);\'>下载</a>";
				htmlText +="<a href=\'javascript:void(0);\' onclick=\'rename("+id+");\'>重命名</a>";
				htmlText +="<a href=\'javascript:void(0);\' onclick=\'deleteAttr("+id+",this);\'>删除</a>";
				htmlText +="</li>";
				htmlText +="</ul>";
				htmlText +="</div>";
				return htmlText;
			}
			
			function refreshAtt(cls,name){
				$("."+cls).val(name);
				$("."+cls).text(name);
				$("."+cls).attr("title",name);
			}
			
			function downAttr(path,name){
				location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/core/resources/"+path+"?name="+name;
			}
			
			function deleteAttr(id){
				if(confirm("确定删除")){
					$.post("<%=basePath%>investment!attrDelete.action?id="+id,function(data){
						showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		location.reload();
			        	}
					});
				}
			}
			
			function rename(id){
				fbSearch('重命名','<%=basePath %>investment!attrRename.action?id='+id,333,67);
			}
			
		</script>
		<style>
		.emaildown .downlistleft {
			width:200px;
		}
		.uploadify-button {
			background: #fff;
			background-position: left center;
			background-repeat: no-repeat;
			border: 1px solid #fff;;
			color: #1F699D;
			font: 12px Arial, Helvetica, sans-serif;
			/*padding-left:10px;*/
			position: relative;
			text-align: center;
			top: 1px;
			width: 100%;
		}
		.emailtop .leftemail ul li span {
			display: inline;
			float: left;
			height: 20px;
			line-height: 20px;
			padding-right: 3px;
			position: relative;
			top:-1px;
		}
		.uploadify:hover .uploadify-button {
			background-color: #fff;
			color: #1F699D;
			background-position: left center;
		}
		.lititle{
			height:18px;
			line-heght:18px;
			display:inline-block;
			max-width:120px;
			overflow:hidden;
		}
		
		.uploadify-progress{
			z-index:99999;
		}
		table{
			table-layout:fixed;
		}
		td{
		}
	</style>
	</head>

	<body style="padding-bottom: 2px;background-color:#fff;">
		<div class="basediv" id="investRight_height" style="border:0px;margin:0px;">
		<div class="divlays" id="investRight_height2" style="margin:0px;padding:0px;">
		<input name="investment.id" type="hidden" value="${id }"/>
		<jsp:include page="common.jsp">
			<jsp:param value="2" name="index"/>
			<jsp:param value="${id}" name="investmentId"/>
		</jsp:include>
		<div class="pm_msglist" id="investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
			<div class="divlays" style="padding:2px 5px 10px 5px;"> 
		 	<div style=" margin:5px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
						<td>
							<div class="merchantsTtitle">
								<ul>
									<li><em>申请报告</em><span><input id="report" type="file"/></span></li>
								</ul>
							</div>
						</td>
					</tr>
					<tr class="agreementTR">
						<td >
							<div class="divlays report" style="padding:2px 5px 0px 5px;">
								<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
									<div class="investmentAtts" id="reportAtts" style="display:block;">
										<c:forEach items="${result.value }" var="attr">
										<c:if test="${attr.attType eq 'REPORT' }">
										<div class="downlistleft">
											<img src="core/common/images/word.png" />
											<input type="hidden" value="${attr.newName }" />
											<input class="att${attr.id }" type="hidden" value="${attr.name }" />
											<ul>
												<li><em class="lititle att${attr.id }" title="${attr.name }">${attr.name }</em></li>
												<li>
													<a href="javascript:void(0);" onclick="downAttr(this);">下载</a>
													<a href="javascript:void(0);" onclick="rename(${attr.id });">重命名</a>
													<a href="javascript:void(0);" onclick="deleteAttr(${attr.id },this);">删除</a>
												</li>
											</ul>
										</div>
										</c:if>
										</c:forEach>
									</div>
									<div class="hackbox"></div>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
		 	<div style=" margin:5px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
						<td>
							<div class="merchantsTtitle">
								<ul>
									<li><em>杭州高新区科技创业服务中心孵化企业概况表</em><span><input id="about" type="file"/></span></li>
								</ul>
							</div>
						</td>
					</tr>
					<tr class="agreementTR">
						<td >
							<div class="divlays about" style="padding:2px 5px 0px 5px;">
								<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
									<div class="investmentAtts" id="aboutAtts" style="display:block;">
									<c:forEach items="${result.value }" var="attr">
										<c:if test="${attr.attType eq 'ABOUT' }">
										<div class="downlistleft">
											<img src="core/common/images/word.png" />
											<input type="hidden" value="${attr.newName }" />
											<input class="att${attr.id }" type="hidden" value="${attr.name }" />
											<ul>
												<li><em class="lititle att${attr.id }" title="${attr.name }">${attr.name }</em></li>
												<li>
													<a href="javascript:void(0);" onclick="downAttr(this);">下载</a>
													<a href="javascript:void(0);" onclick="rename(${attr.id });">重命名</a>
													<a href="javascript:void(0);" onclick="deleteAttr(${attr.id },this);">删除</a>
												</li>
											</ul>
										</div>
										</c:if>
										</c:forEach>
									</div>
									<div class="hackbox"></div>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div style=" margin:5px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
						<td>
							<div class="merchantsTtitle">
								<ul>
									<li><em>法定代表人简介</em><span><input id="legal" type="file"/></span></li>
								</ul>
							</div>
						</td>
					</tr>
					<tr class="agreementTR">
						<td >
							<div class="divlays legal" style="padding:2px 5px 0px 5px;">
								<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
									<div class="investmentAtts" id="legalAtts" style="display:block;">
										<c:forEach items="${result.value }" var="attr">
										<c:if test="${attr.attType eq 'LEGAL' }">
										<div class="downlistleft">
											<img src="core/common/images/word.png" />
											<input type="hidden" value="${attr.newName }" />
											<input class="att${attr.id }" type="hidden" value="${attr.name }" />
											<ul>
												<li><em class="lititle att${attr.id }" title="${attr.name }">${attr.name }</em></li>
												<li>
													<a href="javascript:void(0);" onclick="downAttr(this);">下载</a>
													<a href="javascript:void(0);" onclick="rename(${attr.id });">重命名</a>
													<a href="javascript:void(0);" onclick="deleteAttr(${attr.id },this);">删除</a>
												</li>
											</ul>
										</div>
										</c:if>
										</c:forEach>
									</div>
									<div class="hackbox"></div>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div style=" margin:5px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
						<td>
							<div class="merchantsTtitle">
								<ul>
									<li><em>杭州高新区科技创业服务中心孵化企业人员名单</em><span><input id="list" type="file"/></span></li>
								</ul>
							</div>
						</td>
					</tr>
					<tr class="agreementTR">
						<td >
							<div class="divlays list" style="padding:2px 5px 0px 5px;">
								<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
									<div class="investmentAtts" id="listAtts" style="display:block;">
										<c:forEach items="${result.value }" var="attr">
										<c:if test="${attr.attType eq 'LIST' }">
										<div class="downlistleft">
											<img src="core/common/images/word.png" />
											<input type="hidden" value="${attr.newName }" />
											<input class="att${attr.id }" type="hidden" value="${attr.name }" />
											<ul>
												<li><em class="lititle att${attr.id }" title="${attr.name }">${attr.name }</em></li>
												<li>
													<a href="javascript:void(0);" onclick="downAttr(this);">下载</a>
													<a href="javascript:void(0);" onclick="rename(${attr.id });">重命名</a>
													<a href="javascript:void(0);" onclick="deleteAttr(${attr.id },this);">删除</a>
												</li>
											</ul>
										</div>
										</c:if>
										</c:forEach>
									</div>
									<div class="hackbox"></div>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div style=" margin:5px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
						<td>
							<div class="merchantsTtitle">
								<ul>
									<li><em>企业章程（工商局注册文件）复印件</em><span><input id="constitution" type="file"/></span></li>
								</ul>
							</div>
						</td>
					</tr>
					<tr class="agreementTR">
						<td >
							<div class="divlays constitution" style="padding:2px 5px 0px 5px;">
								<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
									<div class="investmentAtts" id="constitutionAtts" style="display:block;">
										<c:forEach items="${result.value }" var="attr">
										<c:if test="${attr.attType eq 'CONSTITUTION' }">
										<div class="downlistleft">
											<img src="core/common/images/word.png" />
											<input type="hidden" value="${attr.newName }" />
											<input class="att${attr.id }" type="hidden" value="${attr.name }" />
											<ul>
												<li><em class="lititle att${attr.id }" title="${attr.name }">${attr.name }</em></li>
												<li>
													<a href="javascript:void(0);" onclick="downAttr(this);">下载</a>
													<a href="javascript:void(0);" onclick="rename(${attr.id });">重命名</a>
													<a href="javascript:void(0);" onclick="deleteAttr(${attr.id },this);">删除</a>
												</li>
											</ul>
										</div>
										</c:if>
										</c:forEach>
									</div>
									<div class="hackbox"></div>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div style=" margin:5px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
						<td>
							<div class="merchantsTtitle">
								<ul>
									<li><em>法定代表人身份证、学历证复印件</em><span><input id="identity" type="file"/></span></li>
								</ul>
							</div>
						</td>
					</tr>
					<tr class="agreementTR">
						<td >
							<div class="divlays identity" style="padding:2px 5px 0px 5px;">
								<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
									<div class="investmentAtts" id="identityAtts" style="display:block;">
										<c:forEach items="${result.value }" var="attr">
										<c:if test="${attr.attType eq 'IDENTITY' }">
										<div class="downlistleft">
											<img src="core/common/images/word.png" />
											<input type="hidden" value="${attr.newName }" />
											<input class="att${attr.id }" type="hidden" value="${attr.name }" />
											<ul>
												<li><em class="lititle att${attr.id }" title="${attr.name }">${attr.name }</em></li>
												<li>
													<a href="javascript:void(0);" onclick="downAttr(this);">下载</a>
													<a href="javascript:void(0);" onclick="rename(${attr.id });">重命名</a>
													<a href="javascript:void(0);" onclick="deleteAttr(${attr.id },this);">删除</a>
												</li>
											</ul>
										</div>
										</c:if>
										</c:forEach>
									</div>
									<div class="hackbox"></div>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div style=" margin:5px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
						<td>
							<div class="merchantsTtitle">
								<ul>
									<li><em>营业执照复印件和税务登记证复印件</em><span><input id="license" type="file"/></span></li>
								</ul>
							</div>
						</td>
					</tr>
					<tr class="agreementTR">
						<td >
							<div class="divlays license" style="padding:2px 5px 0px 5px;">
								<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
									<div class="investmentAtts" id="licenseAtts" style="display:block;">
										<c:forEach items="${result.value }" var="attr">
										<c:if test="${attr.attType eq 'LICENSE' }">
										<div class="downlistleft">
											<img src="core/common/images/word.png" />
											<input type="hidden" value="${attr.newName }" />
											<input class="att${attr.id }" type="hidden" value="${attr.name }" />
											<ul>
												<li><em class="lititle att${attr.id }" title="${attr.name }">${attr.name }</em></li>
												<li>
													<a href="javascript:void(0);" onclick="downAttr(this);">下载</a>
													<a href="javascript:void(0);" onclick="rename(${attr.id });">重命名</a>
													<a href="javascript:void(0);" onclick="deleteAttr(${attr.id },this);">删除</a>
												</li>
											</ul>
										</div>
										</c:if>
										</c:forEach>
									</div>
									<div class="hackbox"></div>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div style=" margin:5px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
						<td>
							<div class="merchantsTtitle">
								<ul>
									<li><em>法人股东的营业执照复印件</em><span><input id="shareholder" type="file"/></span></li>
								</ul>
							</div>
						</td>
					</tr>
					<tr class="agreementTR">
						<td >
							<div class="divlays shareholder" style="padding:2px 5px 0px 5px;">
								<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
									<div class="investmentAtts" id="shareholderAtts" style="display:block;">
										<c:forEach items="${result.value }" var="attr">
										<c:if test="${attr.attType eq 'SHAREHOLDER' }">
										<div class="downlistleft">
											<img src="core/common/images/word.png" />
											<input type="hidden" value="${attr.newName }" />
											<input class="att${attr.id }" type="hidden" value="${attr.name }" />
											<ul>
												<li><em class="lititle att${attr.id }" title="${attr.name }">${attr.name }</em></li>
												<li>
													<a href="javascript:void(0);" onclick="downAttr(this);">下载</a>
													<a href="javascript:void(0);" onclick="rename(${attr.id });">重命名</a>
													<a href="javascript:void(0);" onclick="deleteAttr(${attr.id },this);">删除</a>
												</li>
											</ul>
										</div>
										</c:if>
										</c:forEach>
									</div>
									<div class="hackbox"></div>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div style=" margin:5px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
						<td>
							<div class="merchantsTtitle">
								<ul>
									<li><em>研发项目简介打印稿</em><span><input id="project" type="file"/></span></li>
								</ul>
							</div>
						</td>
					</tr>
					<tr class="agreementTR">
						<td >
							<div class="divlays project" style="padding:2px 5px 0px 5px;">
								<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
									<div class="investmentAtts" id="projectAtts" style="display:block;">
										<c:forEach items="${result.value }" var="attr">
										<c:if test="${attr.attType eq 'PROJECT' }">
										<div class="downlistleft">
											<img src="core/common/images/word.png" />
											<input type="hidden" value="${attr.newName }" />
											<input class="att${attr.id }" type="hidden" value="${attr.name }" />
											<ul>
												<li><em class="lititle att${attr.id }" title="${attr.name }">${attr.name }</em></li>
												<li>
													<a href="javascript:void(0);" onclick="downAttr(this);">下载</a>
													<a href="javascript:void(0);" onclick="rename(${attr.id });">重命名</a>
													<a href="javascript:void(0);" onclick="deleteAttr(${attr.id },this);">删除</a>
												</li>
											</ul>
										</div>
										</c:if>
										</c:forEach>
									</div>
									<div class="hackbox"></div>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			
			<div style=" margin:5px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
						<td>
							<div class="merchantsTtitle">
								<ul>
									<li><em>其他材料</em><span><input id="other" type="file"/></span></li>
								</ul>
							</div>
						</td>
					</tr>
					<tr class="agreementTR">
						<td >
							<div class="divlays otherSrc" style="padding:2px 5px 0px 5px;">
								<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
									<div class="investmentAtts" id="otherAtts" style="display:block;">
										<c:forEach items="${result.value }" var="attr">
										<c:if test="${attr.attType eq 'OTHER' }">
										<div class="downlistleft">
											<img src="core/common/images/word.png" />
											<input type="hidden" value="${attr.newName }" />
											<input class="att${attr.id }" type="hidden" value="${attr.name }" />
											<ul>
												<li><em class="lititle att${attr.id }" title="${attr.name }">${attr.name }</em></li>
												<li>
													<a href="javascript:void(0);" onclick="downAttr(this);">下载</a>
													<a href="javascript:void(0);" onclick="rename(${attr.id });">重命名</a>
													<a href="javascript:void(0);" onclick="deleteAttr(${attr.id },this);">删除</a>
												</li>
											</ul>
										</div>
										</c:if>
										</c:forEach>
									</div>
									<div class="hackbox"></div>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
	  	</div>
		</div>
	</div>
	</div>
	</div>
	 <div id="testWidth" class="hide"></div>
	</body>
</html>
