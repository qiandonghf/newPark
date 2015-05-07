/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:

	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.toolbarGroups = [
	    { name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
		{ name: 'links' },
		{ name: 'colors' },
		{ name: 'insert' },
		{ name: 'others' },
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align' ] },
		{ name: 'styles' },
		{ name: 'tools' , groups: ['Maximize']} 
		
	];
	
	config.toolbar = 'Basic';

	config.toolbar_Full =
	[
	    ['Source','-','Save','NewPage','Preview','-','Templates'],
	    ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
	    ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
	    ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
	    '/',
	    ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
	    ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
	    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	    ['Link','Unlink','Anchor'],
	    ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
	    '/',
	    ['Styles','Format','Font','FontSize'],
	    ['TextColor','BGColor'],
	    ['Maximize', 'ShowBlocks','-','About']
	];

	config.toolbar_Basic =
	[
	 	['Bold','Italic','Underline','Strike'],['Styles','Format','Font','FontSize'],
	 	['Source','-','Preview'],
	 	['TextColor','BGColor', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink','-','JustifyLeft','JustifyCenter','JustifyRight','-','Image','Flash','Table','-','Maximize']
	];
	
	config.font_names = '宋体/宋体;黑体/黑体;仿宋/仿宋_GB2312;楷体/楷体_GB2312;隶书/隶书;幼圆/幼圆;'+ config.font_names ;
	//config.removeButtons = 'Subscript,Superscript';
	//config.removeButtons = 'Underline,Subscript,Superscript';
	
	config.language = 'zh-cn';
	config.enterMode = CKEDITOR.ENTER_BR;
	config.shiftEnterMode = CKEDITOR.ENTER_P;
	
//	config.filebrowserBrowseUrl = 'ckeditor/uploader/browse.jsp';
//	config.filebrowserUploadUrl = 'ckeditor/uploader/upload.jsp';
//	config.filebrowserFlashBrowseUrl = 'ckeditor/uploader/browse.jsp?type=Flashs';
//	config.filebrowserFlashUploadUrl = 'ckeditor/uploader/upload.jsp?type=Flashs';
	config.filebrowserImageBrowseUrl = '/parkmanager.cms/web/content/web/ckeditor/uploader/browse.jsp';
	config.filebrowserImageUploadUrl = '/parkmanager.cms/web/content/web/ckeditor/uploader/upload.jsp';
	
	config.filebrowserWindowWidth = '640';
	config.filebrowserWindowHeight = '480';
	config.forcePasteAsPlainText =false;
	config.fullPage = true;
	config.allowedContent=true;
	
};
