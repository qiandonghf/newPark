/*
Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
//	Define changes to default configuration here. For example:
//	config.uiColor = '#AADC6E';
	config.language = 'zh-cn';//语言
//	config.filebrowserBrowseUrl = 'ckeditor/uploader/browse.jsp';
//	config.filebrowserImageBrowseUrl = 'ckeditor/uploader/browse.jsp';
//	config.filebrowserFlashBrowseUrl = 'ckeditor/uploader/browse.jsp?type=Flashs';
//	config.filebrowserUploadUrl = 'ckeditor/uploader/upload.jsp';
//	config.filebrowserImageUploadUrl = 'ckeditor/uploader/upload.jsp';
//	config.filebrowserFlashUploadUrl = 'ckeditor/uploader/upload.jsp?type=Flashs';
//	config.filebrowserWindowWidth = '640';
//	config.filebrowserWindowHeight = '480';
	config.skin = 'v2';//皮肤
	config.toolbarStartupExpanded = true;//默认工具栏是否展开
	config.enterMode = CKEDITOR.ENTER_BR; //可选：CKEDITOR.ENTER_BR或CKEDITOR.ENTER_DIV
	config.toolbar = 'Customer';
	config.toolbar_Customer = [
		['TextColor','Bold', 'Italic', 'Underline', '-', 'MyButton','NumberedList', 'BulletedList','-','JustifyLeft','JustifyCenter','JustifyRight'],
		 ['Image','Table','HorizontalRule','Smiley','SpecialChar','PageBreak']
	]
//	config.toolbar = 'Full';
	config.filebrowserImageBrowseUrl = '/ckeditor/uploader/browse.jsp';
	config.filebrowserImageUploadUrl = '/ckeditor/uploader/upload.jsp';
    //config.filebrowserFlashUploadUrl = './ckeditor/upload.php?type=flash';
    config.autoUpdateElement = true; 
};
