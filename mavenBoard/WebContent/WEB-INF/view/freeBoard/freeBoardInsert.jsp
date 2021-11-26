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
	const as = confirm("글을 저장하시겠습니까?")
	if(as){
	$.ajax({
		url : './freeBoardInsertPro.ino',
		data : data,
		type : 'post',
		success : function(data){
			if(data.result){
				const ask = confirm("메인화면으로 가시겠습니까?");
				if(ask){
					location.href = './main.ino';
				}else{
					location.href = './freeBoardDetail.ino?num='+data.num;
				}
			}else{
				alert("글쓰기 실패",error);
			}
		},error : function(){
			alert("내용 전송 실패");
		}
	});
	}
	
}
</script>
	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form id = "ins">

		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select id = "codeType" name = "codeType">
							<option value="01">자유</option>
							<option value="02">익명</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65" id="content"></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="글쓰기" onclick="boardwrite()">
					<input type="button" value="다시쓰기" onclick="reset()">
					<input type="button" value="취소" onclick="'location.href=./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>



</body>
</html>