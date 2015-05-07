<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
int order1 = 1;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv=Content-Type content="text/html; charset=x-cp20936">
<style>
* { font-size:14pt;}
</style>
<title>光纤以太网接入协议书</title>


</head>

<body lang=ZH-CN style='text-justify-trim:punctuation'>

<div class=WordSection1 style='layout-grid:15.6pt;width:960px; margin:0 auto;'>

<p class=MsoNormal align=center style='text-align:center;line-height:27.0pt'><b><span
style='font-size:20.0pt;font-family:宋体;letter-spacing:-.2pt'>宽带网接入协议书</span></b><span
lang=EN-US style='font-size:7.5pt;letter-spacing:-.2pt'>&nbsp;</span></p>
<p class=MsoNormal style='line-height:27.0pt'><b><span style='font-size:14.0pt;
font-family:宋体;letter-spacing:-.2pt'>甲方：万轮科技创业中心</span></b><b><span
style='font-size:14.0pt;letter-spacing:-.2pt'> <span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></b><b><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>（以下简称甲方）</span></b></p>

<p class=MsoNormal style='line-height:27.0pt'><b><span style='font-size:14.0pt;
font-family:宋体;letter-spacing:-.2pt'>乙方：${result.value.customerName}</span></b><b><span
lang=EN-US style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>&nbsp; </span></b><b><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></b><b><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>（以下简称乙方）</span></b></p>
<p class=MsoNormal style='text-indent:28.5pt;line-height:27.0pt'><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>上述甲、乙双方经友好协商一致，达成本协议。双方申明都已理解并认可了本协议的所有内容，同意承担各自应承担的义务，忠实地履行本协议。</span></p>

<p class=MsoNormal style='text-indent:27.2pt;line-height:27.0pt'><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>
一、双方共同遵守《万轮科技创业基地信息化管理办法（暂行）》。</span></p>

<p class=MsoNormal align=left style='text-align:left;text-indent:27.2pt;
line-height:27.0pt'><span style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>
二、按照乙方需求，甲方以</span><span lang=EN-US style='font-size:14.0pt;letter-spacing:
-.2pt'>LAN</span><span style='font-size:14.0pt;font-family:宋体;letter-spacing:
-.2pt'>方式</span><u><span lang=EN-US style='font-size:14.0pt;letter-spacing:
-.2pt'>${result.value.contractItemList}</span></u><span style='font-size:14.0pt;font-family:宋体;
letter-spacing:-.2pt'>速率接入国际互联网，光纤及大厦内部局域网由甲方负责施工，乙方租用。</span></p>

<c:set value="0" var="pf"/>
<c:forEach items="${result.value.rentList}" var="plan" varStatus="status">
		<fmt:formatNumber pattern="#0.00" value="${plan.total}" var="planFee" />
		<c:set value="${pf+planFee}" var="pf"/>
</c:forEach>

<p class=MsoNormal align=left style='text-align:left;text-indent:27.2pt;
line-height:27.0pt'><span style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>
三、乙方宽带接入包月制</span><u><span style='font-size:14.0pt;letter-spacing:-.2pt'>
<span lang=EN-US><fmt:formatNumber pattern="#0.00" value="${result.value.price}"/></span></span></u><span style='font-size:14.0pt;
font-family:宋体;letter-spacing:-.2pt'>元</span><span lang=EN-US style='font-size:
14.0pt;letter-spacing:-.2pt'>/</span><span style='font-size:14.0pt;font-family:
宋体;letter-spacing:-.2pt'>月，协议期费用共计</span><u><span style='font-size:14.0pt;
letter-spacing:-.2pt'> <span lang=EN-US><fmt:formatNumber pattern="#0.00" value="${pf}" var="planFeeTotal" />${planFeeTotal}</span></span></u><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>元。分两次支付，具体支付方式如下：</span></p>

<c:forEach items="${result.value.rentList}" var="plan">
		<p class=Web style='margin-top:5.0pt;margin-right:1.3pt;margin-bottom:5.0pt;margin-left:.05pt;text-indent:24.0pt;line-height:20.0pt'>
			第<span lang=EN-US><%=order1++%></span>次在<u><span lang=EN-US><fmt:formatDate value="${plan.payDate}" type="date" dateStyle="long"/></span></u>前支付，计<u><span
			lang=EN-US><fmt:formatNumber pattern="#0.00" value="${plan.total}" var="planFee" />${planFee}</span></u><span lang=EN-US> </span>元；
		</p>
</c:forEach>

<p class=MsoNormal style='text-indent:27.2pt;line-height:27.0pt'><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>若遇到实际使用期限不足协议期的情况下，按实际使用期限计费，超收的预付款退还乙方。本协议所定资费标准在协议期内，网速提高或遇国家资费调整的，以上费用也作相应调整。</span></p>

<p class=MsoNormal style='text-indent:27.2pt;line-height:27.0pt'><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>
四、甲方为乙方按第三款内容提供</span><u><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp; ${result.value.ipCount}</span></u><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>段内部</span><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>IP</span><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>、</span><u><span
style='font-size:14.0pt;letter-spacing:-.2pt'> <span lang=EN-US>${result.value.portCount}</span></span></u><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>个网络接入端口和</span><u><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp;${result.value.pubIpCount}</span></u><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>个公网</span><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>IP</span><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>地址。</span></p>

<p class=MsoNormal style='text-indent:27.2pt;line-height:27.0pt'><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>
五、上述费用付款方式为现金支付或转帐支付给甲方。</span></p>

<p class=MsoNormal style='text-indent:27.2pt;line-height:27.0pt'><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>
六、甲方向乙方提供必要的相关设备和管理，乙方自行建设或扩建、管理内部网络。乙方不得将线路和设备转租给第三方使用。</span></p>

<p class=MsoBodyTextIndent style='text-indent:27.2pt;line-height:27.0pt'><span
style='font-family:宋体;letter-spacing:-.2pt'>
七、甲方承担乙方所租用线路的维护、保养及抢修，以保证乙方的正常使用。若因乙方原因造成通讯故障，甲方协助排除故障，由此产生的合理费用由乙方支付。</span></p>

<p class=MsoBodyTextIndent style='text-indent:27.2pt;line-height:27.0pt'><span
style='font-family:宋体;letter-spacing:-.2pt'>
八、未经甲方同意，乙方不得任意移动或整改进入乙方室内的线路。乙方在租用期限内因其他原因而要求甲方调整、迁移线路的，所需费用由乙方承担。</span></p>

<p class=MsoNormal style='text-indent:27.2pt;line-height:27.0pt'><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>
九、如乙方违约，则违约方应承担由此引发的一切损失。该宽带网接入仅限于乙方日常通信，不得移借他用，也不得提供给其他单位、个人使用或共享使用。乙方应严格执行</span><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>CHINANET</span><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>用户入网责任书中各项规定，不得利用互联网络从事非正常活动，否则甲方有权提前终止协议。</span></p>

<p class=MsoBodyTextIndent style='text-indent:27.2pt;line-height:27.0pt'><span
style='font-family:宋体;letter-spacing:-.2pt'>
十、除上一条款所列情况，甲乙双方不得单方面提前终止协议。若乙方未经甲方同意提前终止协议，乙方须向甲方支付协议中余下时段的总费用；若甲方未经乙方同意而提前终止协议，甲方须向乙方退还已收取的费用。</span></p>

<p class=MsoBodyText style='text-indent:27.2pt;line-height:27.0pt'><span
style='font-family:宋体;letter-spacing:-.2pt'>
十一、任何一方对本协议内容和对方当事人的商业秘密负有保密义务。订立本协议所依据的法律、行政法规、规章发生变化，本协议将变更相关内容；订立本协议所依据的客观情况发生重大变化，致使本协议无法履行的，经甲乙双方协商同意，可以变更本协议相关内容或者终止协议的履行。</span></p>

<p class=MsoBodyTextIndent style='text-indent:27.2pt;line-height:27.0pt'><span
style='font-family:宋体;letter-spacing:-.2pt'>
十二、本协议一式两份，双方签字盖章后生效，甲方执一份，乙方执一份，具有同等法律效力。未尽事宜，根据相关规定双方友好协商解决。</span></p>

<p class=MsoNormal style='text-indent:27.2pt;line-height:27.0pt'><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>十三、本协议有效期为</span>
<u><span lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>
<fmt:formatDate value="${result.value.startDate}" type="date" dateStyle="long"/>
</u><span style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>至</span><u><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>
<fmt:formatDate value="${result.value.endDate}" type="date" dateStyle="long"/>
</span></u><span style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>，协议期满，经双方同意，再行续订。</span></p>

<p class=MsoNormal style='line-height:27.0pt'><b><span style='font-size:14.0pt;
font-family:宋体;letter-spacing:-.2pt'>
甲方：万轮科技创业中心</span></b><b><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;</span></b><b><span style='font-size:14.0pt;font-family:宋体;letter-spacing:
-.2pt'>
乙方：</span></b><b><span style='font-size:14.0pt;letter-spacing:-.2pt'> </span></b></p>

<p class=MsoNormal style='line-height:27.0pt'><b><span lang=EN-US
style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></b></p>

<p class=MsoNormal style='line-height:27.0pt'><b><span lang=EN-US
style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp; </span></b><b><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>（盖章）</span></b><b><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></b><b><span style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>（盖章）</span></b></p>

<p class=MsoNormal style='line-height:27.0pt'><b><span lang=EN-US
style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></b></p>

<p class=MsoNormal style='line-height:27.0pt'><b><span style='font-size:14.0pt;
font-family:宋体;letter-spacing:-.2pt'>授权代表签字：</span></b><b><span lang=EN-US
style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;</span></b><b><span style='font-size:14.0pt;font-family:宋体;
letter-spacing:-.2pt'>授权代表签字：</span></b><b><span lang=EN-US style='font-size:
14.0pt;letter-spacing:-.2pt'>&nbsp; </span></b></p>

<p class=MsoNormal style='line-height:27.0pt'><b><span style='font-size:14.0pt;
font-family:宋体;letter-spacing:-.2pt'>联系电话：</span></b><b><span lang=EN-US
style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></b><b><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>联系电话：</span></b><b><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp; </span></b></p>

<p class=MsoNormal style='line-height:27.0pt'><b><span lang=EN-US
style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp;</span></b><b><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>年</span></b><b><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp;&nbsp;&nbsp; </span></b><b><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>月</span></b><b><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp;&nbsp;&nbsp; </span></b><b><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>日</span></b><b><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></b><b><span style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>年</span></b><b><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp;&nbsp;&nbsp; </span></b><b><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>月</span></b><b><span
lang=EN-US style='font-size:14.0pt;letter-spacing:-.2pt'>&nbsp;&nbsp;&nbsp; </span></b><b><span
style='font-size:14.0pt;font-family:宋体;letter-spacing:-.2pt'>日</span></b></p>

</div>

</body>

</html>
