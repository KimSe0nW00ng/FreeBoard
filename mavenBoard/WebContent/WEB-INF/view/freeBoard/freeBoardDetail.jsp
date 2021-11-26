<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">


function modify(){
	var data = $("#insertForm").serialize();
	console.log(data);
	const as = confirm("글을 저장하시겠습니까?")
	if(as){
	$.ajax({
		url : './freeBoardModify.ino',
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

function del(){
	var num = $("#num").val();
	
	const as = confirm("글을 삭제하시겠습니까?")
	if(as){
	$.ajax({
		url : './freeBoardDelete.ino',
		data : {num : num},
		type : 'post',
		success : function(data){
			location.href = './main.ino';
		},error : function(){
			alert("내용 삭제 실패");
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

	<form id="insertForm">
		<input type="hidden" name="num" id = "num" value="${freeBoardDto.num }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name = "codeType">
							<option value="01" <c:if test="${freeBoardDto.codeType eq 01}">selected</c:if> >자유</option>
							<option value="02" <c:if test="${freeBoardDto.codeType eq 02}">selected</c:if> >익명</option>
							<option value="03" <c:if test="${freeBoardDto.codeType eq 03}">selected</c:if> >QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="수정" onclick="modify()">
					<input type="button" value="삭제" onclick="del()">
					<input type="button" value="취소" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>


<%-- 	<input type="hidden" name="num" value="${freeBoardDto.num }" />

		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></div>

		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"  value="${freeBoardDto.title }"/></div>

		<div style="width: 150px; float: left;">작성날자</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="regdate"  value="${freeBoardDto.regdate }"/></div>

		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></div>
		<div align="right">
		<input type="button" value="수정" onclick="modify()">
		<input type="button" value="삭제" onclick="location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }'">

		<input type="button" value="취소" onclick="location.href='./main.ino'">
		&nbsp;&nbsp;&nbsp;
		</div> --%>

</body>
</html>