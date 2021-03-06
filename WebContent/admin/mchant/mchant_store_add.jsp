<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
	<head>
		<title>门店添加</title>
		<script language="javascript" src="<%=basePath%>scripts/common.js"></script>
		<script language="javascript" src="<%=basePath%>scripts/Windows.js"></script>
		<link href="<%=basePath%>themes/admin/css.css" rel="stylesheet" type="text/css" />
		<LINK href="<%=basePath%>themes/admin/user_userinfo.css" type=text/css
			rel=stylesheet>
		<LINK href="<%=basePath%>themes/admin/common.css" type=text/css rel=stylesheet>
		<LINK href="<%=basePath%>themes/admin/userhome.css" type=text/css rel=stylesheet>
		<script src="<%=basePath%>scripts/jQuery/jquery-1.2.6.js" type="text/javascript"></script>
		<script src="<%=basePath%>scripts/jQuery/formValidator.js" type="text/javascript"></script>
		<script language="javascript" src="<%=basePath%>scripts/jQuery/jquery.loadmask.js"></script>
		<link href="<%=basePath%>themes/admin/jquery.loadmask.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../scripts/dateNew/My97DatePicker/date.js"></script>
		<script language="javascript" src="../scripts/dateNew/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="../scripts/zgjson/province.js"></script>
		<script type="text/javascript" src="../scripts/zgjson/city.js"></script>
		<script type="text/javascript" src="../scripts/zgjson/District.js"></script>
		<script type="text/javascript">
			function addAccount(){
				var table = document.getElementById("account_table"); 
				var row = table.insertRow(table.rows.length);
				var td1 = row.insertCell(0);
				td1.align="center";
				var index = table.rows.length-2;
				td1.innerHTML = index;
				var td3 = row.insertCell(1);
				td3.align="center";
				td3.innerHTML="<input type='text' id='account_number"+index+"' required=\"required\" name='account_number"+index+"' />";
				var td4 = row.insertCell(2);
				td4.align="center";
				td4.innerHTML="<select name='authority"+index+"' id='authority"+index+"'><option value='0'>所有权限</option>"+
				  			  "<option value='1'>交易验证</option></select>";
				var td5 = row.insertCell(3);
				td5.align="center";
				td5.innerHTML="<input type='text' id='remark"+index+"' required=\"required\" name='remark"+index+"' />";
				var td6 = row.insertCell(4);
				td6.align="center";
				td6.innerHTML = "<input type='button' value='删除' onclick='removeTr("+(table.rows.length-1)+",\"account_table\")'/>";
			}
			
			function removeTr(tr_id,table_id){
				var table = document.getElementById(table_id); 
				table.deleteRow(tr_id);
				var table2 = document.getElementById(table_id); 
				for(var i=2;i<table2.rows.length;i++){
					table2.rows[i].cells[0].innerHTML = i-1;
					if(table_id=="account_table"){
						table2.rows[i].cells[5].innerHTML = "<input type='button' value='删除' onclick='removeTr("+i+",\"account_table\")'/>";
					}else{
						table2.rows[i].cells[7].innerHTML = "<input type='button' value='删除' onclick='removeTr("+i+",\"card_table\")'/>";
					}
				}
			}
			
			function addStore(){
				var table = document.getElementById("account_table"); 
				var rows = table.rows.length;
				if(rows<4){
					alert("每个门店请至少添加一个交易验证和所有权限的账户");
					return false;
				}
				var json = "["
				for(var i=1;i<=rows-2;i++){
					json = json+"{";
					var account_number = document.getElementById("account_number"+i).value;
					var authority = document.getElementById("authority"+i).value;
					var remark = document.getElementById("remark"+i).value;
					json = json +"'account_number':'"+account_number+"','authority':'"+authority+"','remark':'"+remark+"'"
					if(i==rows-2){
						json = json+"}";
					}else{
						json = json+"},";
					}
				}
				json = json +"]";
				document.getElementById("storeAccountJosn").value=json; 
				frmPage.submit();
			}
		</script>
	</head>
	<body>
		<form name="frmPage" id="queryFrom" action="savemchantStore.jhtml"  method="post"
			enctype="multipart/form-data">
			<input type="hidden" id="mchantNo" name="mchantNo" value="${mchantNo}"/>
			<input type="hidden" id="mch_name" name="mch_name" value="${mch_name}"/>
			<input type="hidden" id="storeAccountJosn" name="storeAccountJosn"/>
			<div>
				<div align="left">
					您现在的位置：商户管理 &gt;&gt;新增商户门店信息
				</div>
				
				<table class="table_a marginb10" id="store_table">
					<tr>
						<th align="left" colspan="12">
							<span style="float: left" >
								<strong>商户名称：${mch_name}&nbsp;&nbsp;&nbsp;商户编号：${mchantNo}</strong>
							</span>
							<span style="float: right">
								<input type="button" value="返回" onclick="javascript:history.back()"/>
							</span>
						</th>
					</tr>
					<tr class="align_Center">
						<td align="center" style="width:50%;">
							门店名称
						</td>
						<td align="center" style="width:50%;">
							<input type="text" id="branch_name" name="branch_name" required="required" />
						</td>
					</tr>
					<tr class="align_Center">
						<td align="center">
							城市
						</td>
						<td align="center">
							<select id="city_id" name="city_id">
								<c:forEach var="item" items="${citysNameList}" varStatus="status">
									<option value="${item.city_id}">${item.city_name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr class="align_Center">
						<td align="center">
							门店图片(请使用zip压缩包，如果不添加图片则该门店图片为该商户图片)
						</td>
						<td align="center">
							<input type="file" id="branch_pic_url" name="branch_pic_url"/>
						</td>
					</tr>
					<tr class="align_Center">
						<td align="center">
							门店地址
						</td>
						<td align="center">
							<input type="text" id="branch_addr" name="branch_addr" required="required" />
						</td>
					</tr>
					<tr class="align_Center">
						<td align="center">
							所属商圈（如果有多个，请用逗号分隔）
						</td>
						<td align="center">
							<input type="text" id="biz_districts" name="biz_districts" required="required" />
						</td>
					</tr>
					<tr class="align_Center">
						<td align="center">
							使用须知（请使用p标签，包含储值卡使用范围、营业时间等；如果不添加使用须知，则默认使用须知为该商户的使用须知）
						</td>
						<td align="center">
							<input type="text" style="width:100%;" id="use_note" name="use_note" value="${mchant.use_note}" required="required"/>
						</td>
					</tr>
					<tr class="align_Center">
						<td align="center">
							联系方式
						</td>
						<td align="center">
							<input type="text" id="telephone" name="telephone" required="required" />
						</td>
					</tr>
					<tr class="align_Center">
						<td align="center">
							经度
						</td>
						<td align="center">
							<input type="text" id="longitude" name="longitude" required="required" />
						</td>
					</tr>
					<tr class="align_Center">
						<td align="center">
							纬度
						</td>
						<td align="center">
							<input type="text" id="latitude" name="latitude" required="required" />
						</td>
					</tr>
				</table>
				<table class="table_a marginb10" id="account_table">
					<tr>
						<th align="left" colspan="6">
							<span style="float: left" >
								门店账号添加
							</span>
							<span style="float: right">
								<input type="button" value="添加" onclick="addAccount()"/>
							</span>
						</th>
					</tr>
					<tr class="align_Center">
						<td align="center">
							序号
						</td>
						<td align="center">
							账号
						</td>
						<td align="center">
							权限
						</td>
						<td align="center">
							备注
						</td>
						<td align="center">
							操作
						</td>
					</tr>
				</table>
				<table class="table_a marginb10" id="account_table">
					<tr>
						<td align="center">
							<input type="button" value="添加" onclick="addStore()">
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>
</html>
