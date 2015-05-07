package com.wiiy.oa.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.mail.MailDto;
import com.wiiy.external.service.dto.EmailAttDto;
import com.wiiy.external.service.dto.Page;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.service.MailService;

public class MailAction{
	public String HOST = "";
	public String SMTPHOST = "";
	public String USER = "";
	public String PASS = "";
	public String INBOX = "INBOX";
	public String SENT_ITEMS = "已发送";
	public String DRAFT = "草稿夹";
	
	private MailService mailService;
	private List<MailDto> mailList;
	private int id;
	private Result result;
	private String receiverEmailAdd;
	private String subject;
	private String content;
	private String attAddress;
	private int folder = 1;//1.INBOX,2.Sent Items 3.DRAFT
	private int type = 1;//1.新建邮件,2.答复,3.全部答复,4.转发,5.发送
	private String receivers;
	private int rowCounts = 20;//每页记录数
	private int maxPage = 1;
	private int page = 1;
	private int partIndex;
	private String fileName;
	private InputStream inputStream;
	private MailDto mailDto;
	private String folderName;
	private int draft;
	
	private String mailFrom;
	private String mailTo;
	
	public String searchMail(){
		emailInfo();
		if(folder==1){
			folderName = INBOX;
		}else if(folder==2){
			folderName = SENT_ITEMS;
		}else{
			folderName = DRAFT;
		}
		result = mailService.searchMail(HOST, USER, PASS,subject,content,mailFrom,mailTo,folderName);
		return "searchMail";
	}
	
	public boolean emailInfo(){
		if(OaActivator.getSessionUser().getUserEmailParam()!=null&&OaActivator.getSessionUser().getUserEmailParam().getEmail()!=null){
			HOST = OaActivator.getSessionUser().getUserEmailParam().getPop3();
			SMTPHOST = OaActivator.getSessionUser().getUserEmailParam().getSmtp();
			USER = OaActivator.getSessionUser().getUserEmailParam().getEmail();
			PASS = OaActivator.getSessionUser().getUserEmailParam().getPasswd();
			if(SMTPHOST.equals("smtp.163.com")||SMTPHOST.equals("smtp.qq.com")){
				DRAFT = "草稿箱";
			}else if(SMTPHOST.equals("smtp.sina.cn")){
				DRAFT = "草稿夹";
			}else if(SMTPHOST.equals("hzwiiy.com")||SMTPHOST.equals("mail.nbbi.net")){
				SENT_ITEMS = "发件箱";
				DRAFT = "草稿";
			}
			return true;
		}
		return false;
	}
	
	public String draftList(){
		if(!emailInfo()){
			return "errorPage";
		}
		folder = 3;
		Page pageObject = new Page();
		//(page-1)*rowCounts+1,page*rowCounts
		pageObject.setPageNo(page);
		pageObject.setPageSize(rowCounts);
		result = mailService.draftList(HOST, USER, PASS,DRAFT,pageObject,subject,content);
		if(!result.isSuccess()){
			return "errorPage";
		}
		mailList = (List<MailDto>) result.getValue();
		if(mailList!= null && mailList.size()>0){
			long totalCount = pageObject.getTotalCount();
			maxPage = (int) (totalCount-1)/rowCounts+1;
		}
		return "list";
	}
	
	public String mailRelay(){
		emailInfo();
		if(folder==1){
			folderName = INBOX;
		}else if(folder==2){
			folderName = SENT_ITEMS;
		}else{
			folderName = DRAFT;
		}
		result = mailService.mail(HOST, USER, PASS, "imap", folderName, id, true);
		MailDto mailDto = (MailDto)result.getValue();
		mailTo = mailDto.getTo().replace("&lt;", "");
		mailTo = mailTo.replace("&gt;", "");
		return "mailRelay";
	}

	public String downloadAttachment(){
		emailInfo();
		if(folder==1){
			folderName = INBOX;
		}else{
			folderName = SENT_ITEMS;
		}
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		result = mailService.downloadAttachment(HOST, USER, PASS, "imap", folderName, id, partIndex,out);
		fileName = StringUtil.URLEncoderToUTF8((String)result.getValue());
		inputStream = new ByteArrayInputStream(out.toByteArray());
		return "downloadAttachment";
	}
	
	public String sendMail(){
		emailInfo();
		if(type==1){
			return "sendMail";
		}
		if(folder==1){
			folderName = INBOX;
		}else if(folder==2){
			folderName = SENT_ITEMS;
		}else{
			folderName = DRAFT;
		}
		result = mailService.mail(HOST, USER, PASS, "imap", folderName, id);
		MailDto mailDto = (MailDto)result.getValue();
		mailTo = mailDto.getTo().replace("&lt;", "");
		mailTo = mailTo.replace("&gt;", "");
		receivers = mailDto.getSender();
		if(type == 3){
			if(mailDto.getCc()!=null && mailDto.getCc()!=""){
				receivers += ";"+mailDto.getCc();
			}
		}
		if(type==5){
			receivers = mailDto.getTo();
		}
		receivers = receivers.replaceAll("<span>", "").replaceAll("</span>", "");
		return "sendMail";
	}
	
	public String send(){
		emailInfo();
		String[] files = attAddress.split(";");
		List<EmailAttDto> attList = new ArrayList<EmailAttDto>();
		for (String string : files) {
			if(!string.equals("")){
				String[] ss = string.split(",");
				EmailAttDto dto = new EmailAttDto();
				dto.setNewName(ss[0]);
				dto.setName(ss[1]);
				attList.add(dto);
			}
		}
		mailDto.setEmailAttDtoList(attList);
		if(draft == 1){
			result = mailService.saveDraft(HOST,SMTPHOST, USER, PASS, mailDto,DRAFT);
		}else{
			result = mailService.send(HOST,SMTPHOST, USER, PASS, mailDto,SENT_ITEMS);
		}
		return "json";
	}

	public String list(){
		if(!emailInfo()){
			return "errorPage";
		}
		folder = 1;
		Page pageObject = new Page();
		//(page-1)*rowCounts+1,page*rowCounts
		pageObject.setPageNo(page);
		pageObject.setPageSize(rowCounts);
		result = mailService.receiveList(HOST, USER, PASS,INBOX,pageObject,subject,content);
		mailList = (List<MailDto>) result.getValue();
		if(!result.isSuccess()){
			return "errorPage";
		}
		if(mailList!= null && mailList.size()>0){
			long totalCount = pageObject.getTotalCount();
			maxPage = (int) (totalCount-1)/rowCounts+1;
		}
		return "list";
	}
	
	public String sendList(){
		if(!emailInfo()){
			return "errorPage";
		}
		folder = 2;
		Page pageObject = new Page();
		//(page-1)*rowCounts+1,page*rowCounts
		pageObject.setPageNo(page);
		pageObject.setPageSize(rowCounts);
		result = mailService.sendList(HOST, USER, PASS,SENT_ITEMS,pageObject,subject,content);
		if(!result.isSuccess()){
			return "errorPage";
		}
		mailList = (List<MailDto>) result.getValue();
		if(mailList!= null && mailList.size()>0){
			long totalCount = pageObject.getTotalCount();
			maxPage = (int) (totalCount-1)/rowCounts+1;
		}
		return "list";
	}
	
	public String mail(){
		emailInfo();
		if(folder==1){
			folderName = INBOX;
		}else if(folder==2){
			folderName = SENT_ITEMS;
		}else{
			folderName = DRAFT;
		}
		result = mailService.mail(HOST, USER, PASS, "imap", folderName, id);
		if(!result.isSuccess()){
			return "errorPage";
		}else{
			return "mail";
		}
	}
	
	public String delete(){
		emailInfo();
		if(folder==1){
			folderName = INBOX;
		}else if(folder==2){
			folderName = SENT_ITEMS;
		}else{
			folderName = DRAFT;
		}
		result = mailService.delete(HOST, USER, PASS, folderName, id);
		return "json";
	}
	
	
	public List<MailDto> getMailList() {
		return mailList;
	}
	public void setMailList(List<MailDto> mailList) {
		this.mailList = mailList;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}
	public String getReceiverEmailAdd() {
		return receiverEmailAdd;
	}
	public void setReceiverEmailAdd(String receiverEmailAdd) {
		this.receiverEmailAdd = receiverEmailAdd;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAttAddress() {
		return attAddress;
	}

	public void setAttAddress(String attAddress) {
		this.attAddress = attAddress;
	}

	public int getFolder() {
		return folder;
	}
	public void setFolder(int folder) {
		this.folder = folder;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getReceivers() {
		return receivers;
	}
	public void setReceivers(String receivers) {
		this.receivers = receivers;
	}
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}
	public int getRowCounts() {
		return rowCounts;
	}

	public void setRowCounts(int rowCounts) {
		this.rowCounts = rowCounts;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}
	public int getPartIndex() {
		return partIndex;
	}

	public void setPartIndex(int partIndex) {
		this.partIndex = partIndex;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public MailDto getMailDto() {
		return mailDto;
	}

	public void setMailDto(MailDto mailDto) {
		this.mailDto = mailDto;
	}

	public int getDraft() {
		return draft;
	}

	public void setDraft(int draft) {
		this.draft = draft;
	}
	public String getMailFrom() {
		return mailFrom;
	}

	public void setMailFrom(String mailFrom) {
		this.mailFrom = mailFrom;
	}

	public String getMailTo() {
		return mailTo;
	}

	public void setMailTo(String mailTo) {
		this.mailTo = mailTo;
	}

}
