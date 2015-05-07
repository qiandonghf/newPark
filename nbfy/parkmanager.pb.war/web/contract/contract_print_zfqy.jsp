<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
int order1 = 1;int order2 = 1;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv=Content-Type content="text/html; charset=x-cp20936">
<style>
* { font-size:14pt;}
</style>
<title>孵化场地租赁合同</title>

</head>

<body bgcolor=white lang=ZH-CN style='tab-interval:21.0pt;text-justify-trim:
punctuation'>

<div class=WordSection1 style='layout-grid:15.6pt; width:960px; margin:0 auto;'>

<p class=Web style='line-height:26.0pt;mso-line-height-rule:exactly'><span
style='font-size:16.0pt;font-family:黑体'>附件：在孵企业<span lang=EN-US><o:p></o:p></span></span></p>

<p class=Web style='mso-char-indent-count:7.5; text-align:center; line-height:
26.0pt;mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
style='font-size:18.0pt;mso-bidi-font-size:10.0pt;font-family:黑体'>孵化场地租赁合同<span
lang=EN-US><o:p></o:p></span></span></b></p>

<p class=Web align=center style='text-align:center;line-height:12.0pt;
mso-line-height-rule:exactly'><span lang=EN-US style='font-size:13.5pt;
mso-bidi-font-size:10.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'><b
style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;mso-bidi-font-size:
10.0pt;font-family:黑体'>甲方（出租方）：万轮科技创业中心<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'><b
style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;mso-bidi-font-size:
10.0pt;font-family:黑体'>乙方（承租方）：<u>${result.value.customerName}<span
lang=EN-US><o:p></o:p></span></u></span></b></p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'><span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp;</span><span
style='mso-spacerun:yes'>&nbsp;</span></span>甲乙双方经友好协商，同意就房屋租赁事项订立本合同，共同遵守。</p>

<p class=Web style='margin-right:1.3pt;line-height:20.0pt;mso-line-height-rule:
exactly;mso-outline-level:1'><b style='mso-bidi-font-weight:normal'>一、出租房屋位置及面积
<span lang=EN-US><o:p></o:p></span></b></p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'><span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>甲方将万轮科技创业大厦<u><span
lang=EN-US>${result.value.contractItemList}</span></u>室，面积为<u><span
lang=EN-US><fmt:formatNumber pattern="#0.00" value="${result.value.areaTotal}"/></span></u>平方米，出租给乙方作为<u>办公用房</u>。乙方对甲方所要出租的场地已作充分了解，愿意承租。</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly;mso-outline-level:
1'><b style='mso-bidi-font-weight:normal'>二、租用面积和租金单价<span lang=EN-US><o:p></o:p></span></b></p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'><span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>本大厦孵化场地租金标准为<span
lang=EN-US>40</span>元<span lang=EN-US>/</span>月&#8226;平方米。</p>

<p class=Web style='text-indent:24.0pt;mso-char-indent-count:2.0;line-height:
20.0pt;mso-line-height-rule:exactly'>甲方提供孵化场地共<u><span lang=EN-US><fmt:formatNumber pattern="#0.00" value="${result.value.areaTotal}"/></span></u>平方米，租金按<u>
<span lang=EN-US><fmt:formatNumber pattern="#0.00" value="${result.value.price}"/></span></u>元<span lang=EN-US>/</span>月&#8226;平方米计（在<span
class=GramE>孵企业</span>收费标准）。</p>

<p class=Web style='margin-right:1.3pt;line-height:20.0pt;mso-line-height-rule:
exactly;mso-outline-level:1'><b style='mso-bidi-font-weight:normal'>三、租金及交租时间</b></p>

<c:set value="0" var="pf"/>
<c:forEach items="${result.value.rentList}" var="plan" varStatus="status">
	<c:if test="${plan.feeType eq 'RENT'}">
		<fmt:formatNumber pattern="#0.00" value="${plan.total}" var="planFee" />
		<c:set value="${pf+planFee}" var="pf"/>
	</c:if>
</c:forEach>

<c:set value="0" var="pf2"/>
<c:forEach items="${result.value.energyList}" var="plan" varStatus="status">
	<c:if test="${plan.feeType eq 'ENERGY'}">
		<fmt:formatNumber pattern="#0.00" value="${plan.total}" var="planFee2" />
		<c:set value="${pf2+planFee2}" var="pf2"/>
	</c:if>
</c:forEach>

<p class=Web style='margin-top:5.0pt;margin-right:1.3pt;margin-bottom:5.0pt;
margin-left:.05pt;text-indent:18.0pt;line-height:20.0pt'><span lang=EN-US>&nbsp;</span>租赁期限自<u>
<span lang=EN-US><fmt:formatDate value="${result.value.startDate}" type="date" dateStyle="long"/>
 </span></u>至<u><span lang=EN-US><fmt:formatDate value="${result.value.endDate}" type="date" dateStyle="long"/></span></u>止。租金共计人民币
<u>&nbsp;<span lang=EN-US><fmt:formatNumber pattern="#0.00" value="${pf}" var="planFeeTotal" />${planFeeTotal}</span></u><span lang=EN-US>&nbsp;</span>元。租金分两次支付，具体支付方式如下：</p>

<c:forEach items="${result.value.rentList}" var="plan">
	<c:if test="${plan.feeType eq 'RENT'}">
		<p class=Web style='margin-top:5.0pt;margin-right:1.3pt;margin-bottom:5.0pt;margin-left:.05pt;text-indent:24.0pt;line-height:20.0pt'>
			第<span lang=EN-US><%=order1++%></span>次在<u><span lang=EN-US><fmt:formatDate value="${plan.payDate}" type="date" dateStyle="long"/></span></u>前支付，计<u><span
			lang=EN-US><fmt:formatNumber pattern="#0.00" value="${plan.total}" var="planFee" />${planFee}</span></u><span lang=EN-US> </span>元；
		</p>
	</c:if>
</c:forEach>

<p class=Web style='margin-top:5.0pt;margin-right:1.3pt;margin-bottom:5.0pt;
margin-left:.05pt;text-indent:24.0pt;line-height:20.0pt;mso-line-height-rule:
exactly'>缴纳租金后才有权使用承租房。</p>

<p class=Web style='line-height:20.0pt'><b>四、乙方需承担所租用面积范围内的能源使用费</b></p>
<p class=Web style='text-indent:24.0pt;line-height:20.0pt'>能源费用（含水、电、空调费用）按<span
lang=EN-US>10</span>元<span lang=EN-US>/</span>月<span lang=EN-US>&middot;</span>平方米计，共计<u><span
lang=EN-US><fmt:formatNumber pattern="#0.00" value="${pf2}" var="planFeeTotal" />${planFeeTotal}</span></u>元。能源费分二次支付，具体支付方式如下：</p>
	
<c:forEach items="${result.value.energyList}" var="plan">
	<c:if test="${plan.feeType eq 'ENERGY'}">
		<p class=Web style='margin-top:5.0pt;margin-right:1.3pt;margin-bottom:5.0pt;margin-left:.05pt;text-indent:24.0pt;line-height:20.0pt'>
			第<span lang=EN-US><%=order2++%></span>次在<u><span lang=EN-US><fmt:formatDate value="${plan.payDate}" type="date" dateStyle="long"/></span></u>前支付，计<u><span
			lang=EN-US><fmt:formatNumber pattern="#0.00" value="${plan.total}" var="planFee" />${planFee}</span></u><span lang=EN-US> </span>元；
		</p>
	</c:if>
</c:forEach>

<p class=Web style='text-indent:24.0pt;mso-char-indent-count:2.0;line-height:
20.0pt;mso-line-height-rule:exactly'><span lang=EN-US>5KW</span>以上生产用电设备，电费另计。</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly;mso-outline-level:
1'><b style='mso-bidi-font-weight:normal'>五、押金条款<span lang=EN-US><o:p></o:p></span></b></p>

<p class=Web style='text-indent:24.0pt;line-height:20.0pt;mso-line-height-rule:
exactly'>乙方在入驻前，与第一次交纳房租的同时交纳押金 <u><span style='mso-spacerun:yes'>&nbsp;</span><span
lang=EN-US><fmt:formatNumber pattern="#0.00" value="${result.value.deposit}" /></span></u><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;</span></span>元，用于抵扣甲方因未及时收到足额房租及能源费。若未出现本款上述情况，甲方将在租赁期满时一次性全额退还乙方押金。</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly;mso-outline-level:
1'><b style='mso-bidi-font-weight:normal'>六、承租房的用途<span lang=EN-US> <o:p></o:p></span></b></p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'><span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp; </span></span>乙方保证承租上述楼房仅<span
class=GramE>作从事</span>万轮国家高新区规定的<u><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp; </span><span
style='mso-spacerun:yes'>&nbsp;</span></span>办公用房<span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span></u>使用。</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly;mso-outline-level:
1'><b style='mso-bidi-font-weight:normal'>七、甲方应承担的义务<span lang=EN-US><o:p></o:p></span></b></p>

<p class=Web style='line-height:20.0pt'><span lang=EN-US>&nbsp;&nbsp;&nbsp; 1</span>、于
	<u><span lang=EN-US><fmt:formatDate value="${result.value.signDate}" type="date" dateStyle="long"/></span></u>按时将正常、适用的场地交付乙方使用。
</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'><span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span>2</span>、负责对场地及其附属建筑物的定期检查和正常的修缮费用。</p>

<p class=Web style='text-indent:12.0pt;mso-char-indent-count:1.0;line-height:
20.0pt;mso-line-height-rule:exactly'><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;</span><span
style='mso-spacerun:yes'>&nbsp;</span>3</span>、若因特殊情况需要变更、解除合同的，应提前与乙方协商解决。</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly;mso-outline-level:
1'><b style='mso-bidi-font-weight:normal'>八、乙方应承担的义务<span lang=EN-US><o:p></o:p></span></b></p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'><span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span><span
style='mso-spacerun:yes'>&nbsp;</span>1</span>、按时、足额缴纳房屋租金。</p>

<p class=Web style='text-indent:27.0pt;line-height:20.0pt;mso-line-height-rule:
exactly'><span lang=EN-US>2</span>、乙方不得在承租的孵化场地内从事违法经营活动。</p>

<p class=Web style='text-indent:27.0pt;line-height:20.0pt;mso-line-height-rule:
exactly'><span lang=EN-US>3</span>、乙方不得将承租的房屋进行抵押、质押、转让、转租。</p>

<p class=Web style='text-indent:12.0pt;mso-char-indent-count:1.0;line-height:
20.0pt;mso-line-height-rule:exactly'><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;</span><span
style='mso-spacerun:yes'>&nbsp;</span>4</span>、如需在承租房内装修或安装大型设备，须申报相关方案征得甲方同意后才能施工，其费用由乙方承担。装修时，不得损坏房屋原有主体结构、固定设施及整体布局；且要使用轻型耐火材料，预留消防安全通道，符合防火标准。</p>

<p class=Web style='text-indent:6.0pt;mso-char-indent-count:.5;line-height:
20.0pt;mso-line-height-rule:exactly'><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;</span><span style='mso-spacerun:yes'>&nbsp;
</span>5</span>、若因乙方原因损坏房屋及其附属建筑物，应及时修复，并赔偿相关损失。</p>

<p class=Web style='text-indent:12.0pt;mso-char-indent-count:1.0;line-height:
20.0pt;mso-line-height-rule:exactly'><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp; </span>6</span>、协助甲方开展正常的房屋检查和维修工作。</p>

<p class=Web style='text-indent:12.0pt;mso-char-indent-count:1.0;line-height:
20.0pt;mso-line-height-rule:exactly'><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;</span><span
style='mso-spacerun:yes'>&nbsp;</span>7</span>、<span style='letter-spacing:
.5pt'>租赁期满不再同意续租的，必须及时腾出全部承租的房屋，</span><span style='letter-spacing:.3pt'>除自行安装的设备外，其他设施（包括不可拆卸装饰物）应完好</span><span
style='letter-spacing:.5pt'>无损地交给甲方。</span></p>

<p class=Web style='text-indent:12.0pt;mso-char-indent-count:1.0;line-height:
20.0pt;mso-line-height-rule:exactly'><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;</span><span
style='mso-spacerun:yes'>&nbsp;</span>8</span>、若因特殊情况需终止合同，须提前<span lang=EN-US>30</span>日书面通知甲方。</p>

<p class=Web style='text-indent:24.0pt;mso-char-indent-count:2.0;line-height:
20.0pt;mso-line-height-rule:exactly'><span lang=EN-US>9</span>、乙方在承租期间需参加创业中心一年一度的企业综合考评，如当年考评级别为“<span
lang=EN-US>C</span>”档，甲方有权无条件提前单方面解除租赁合同，乙方须及时搬离承租房屋。如乙方坚持不同意搬离承租场地，即日起租金上浮为标准价<span
lang=EN-US>40</span>元<span lang=EN-US>/</span>月&#8226;平方米。</p>

<p class=Web style='text-indent:12.0pt;mso-char-indent-count:1.0;line-height:
20.0pt;mso-line-height-rule:exactly'><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;</span><span
style='mso-spacerun:yes'>&nbsp;</span>10</span>、在承租期间，必须服从高新区和创业中心的管理。</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly;mso-outline-level:
1'><b style='mso-bidi-font-weight:normal'>九、违约责任<span lang=EN-US><o:p></o:p></span></b></p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'><span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span>1</span>、如一方违反有关政策法规，或违反双方签订的协议（合同）事项，另一方有权提前解除合同，由此造成的损失由责任一方承担。</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'><span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span>2</span>、如乙方违反本合同第八条第三款，甲方有权解除合同，乙方应按年租金额向甲方支付违约金。</p>

<p class=Web style='text-indent:12.0pt;mso-char-indent-count:1.0;line-height:
20.0pt;mso-line-height-rule:exactly'><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;</span><span
style='mso-spacerun:yes'>&nbsp;</span>3</span>、甲方未如期交付出租场地的，每逾期一日按月租金的<span
lang=EN-US>5% </span>向乙方支付违约金。</p>

<p class=Web style='text-indent:12.0pt;mso-char-indent-count:1.0;line-height:
20.0pt;mso-line-height-rule:exactly'><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;</span><span
style='mso-spacerun:yes'>&nbsp;</span>4</span>、乙方逾期交付房租，每逾期一日按月租金的<span
lang=EN-US>5% </span>向甲方支付违约金。逾期一个月不交房租的，甲方有权解除合同并收回房屋，乙方应在<span lang=EN-US>7</span>日内腾退所租场地内物品，如逾期不履行的，甲方为维护自身权利有权处置乙方所租场地内物品，由此产生的后果应由乙方自负，甲方不承担相关责任。</p>

<p class=Web style='text-indent:12.0pt;mso-char-indent-count:1.0;line-height:
20.0pt;mso-line-height-rule:exactly'><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;</span><span
style='mso-spacerun:yes'>&nbsp;</span>5</span>、承租期满，甲、乙双方未<span class=GramE>签定</span>续租合同的，乙方应及时腾退全部场地。否则，每逾期一日应加付月租金的<span
lang=EN-US>5% </span>，并承担由此造成甲方的其他经济损失。</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly;mso-outline-level:
1'>十、因不可抗力造成任何一方财产、人身损害的，双方均可免责。</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly;mso-outline-level:
1'>十一、本合同未尽事宜，甲乙双方可另行签订补充协议，其效力与本合同相同。</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly;mso-outline-level:
1'>十二、本合同经双方签字后生效；待乙方取得企业营业执照后，双方补盖公章。</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly;mso-outline-level:
1'>十三、本合同一式二份，甲乙双方各执一份。</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'><span
lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'>甲方（盖章）：<span
lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span>乙方（盖章）：</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'>代表签字：<span
lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span>代表签字：</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'>联系电话：<span
lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span>联系电话：</p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'><span
lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=Web style='line-height:20.0pt;mso-line-height-rule:exactly'><span
lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span>年<span lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span>月<span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>日<span
lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>年<span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>月<span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>日</p>

</div>

</body>

</html>