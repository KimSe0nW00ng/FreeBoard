<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
function boardwrite(){
	var data = $("#ins").serialize();
	console.log(data);
	const as = confirm("���� �����Ͻðڽ��ϱ�?")
	if(as){
	$.ajax({
		url : './freeBoardInsertPro.ino',
		data : data,
		type : 'post',
		success : function(data){
			if(data.result){
				const ask = confirm("����ȭ������ ���ðڽ��ϱ�?");
				if(ask){
					location.href = './main.ino';
				}else{
					location.href = './freeBoardDetail.ino?num='+data.num;
				}
			}else{
				alert("�۾��� ����",error);
			}
		},error : function(){
			alert("���� ���� ����");
		}
	});
	}
	
}
</script>
	<div>
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">

	<form id = "ins">

		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">Ÿ�� :</td>
					<td style="width: 400px;">
						<select id = "codeType" name = "codeType">
							<option value="01">����</option>
							<option value="02">�͸�</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">�̸� :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65" id="content"></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="�۾���" onclick="boardwrite()">
					<input type="button" value="�ٽþ���" onclick="reset()">
					<input type="button" value="���" onclick="'location.href=./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>



</body>
</html>