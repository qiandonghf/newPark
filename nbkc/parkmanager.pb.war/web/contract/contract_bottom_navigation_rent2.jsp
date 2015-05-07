<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<div class="apptab" id="tableid">
	<ul>
		<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">租赁房间</li>
		<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">资金计划</li>
		<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)">押金</li>
		<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',3)">合同附件</li>
		<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',4)">合同备忘</li>
		<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',5)">合同审批</li>
		<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',6)">合同变更</li>
		<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',7)">优惠信息</li>
	</ul>
</div>