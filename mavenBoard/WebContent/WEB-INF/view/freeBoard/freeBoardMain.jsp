<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<script type="text/javascript">


$(function(){
	var chkObj = $("input[name = 'Rowcheck']");
	var rowCnt = chkObj.length;
	
	$("input[name = 'Allcheck']").click(function(){
		var chk_listArr = $("input[name = 'Rowcheck']");
		for(var i=0; i<chk_listArr.length; i++){
			chk_listArr[i].checked = this.checked;
		}
	});
	
	$("input[name = 'Rowcheck']").click(function(){
			if($("input[name = 'Rowcheck']:checked").length == rowCnt){
				$("input[name = 'Allcheck']")[0].checked = true;
			}else{
				$("input[name = 'Allcheck']")[0].checked = false;
		}
	});
	
	
	
});
function deleteValue(){
	var valueArr = new Array();
	var list = $("input[name = 'Rowcheck']");
	for(var i =0; i< list.length; i++){
		if(list[i].checked){
		valueArr.push(list[i].value);
		}
	}
	
	if(valueArr.length == 0){
		alert("선택된 글이 없습니다.");
	}else{
		const as = confirm("정말 삭제하시겠습니까?");
		if(as){
			$.ajax({
				url : 'freeBoardCheckDelete.ino',
				type : 'post',
				data : {valueArr : valueArr},
				success : function(data){
					location.href = './main.ino';
				},error : function(data){
					alert("체크박스 글 삭제 실패");
				}
			});
		}else{
			
		}
	}
}
function chageLangSelect(){
	var sv = $("#selectValue").val();
	var str = "";
	console.log(sv);
		$("#optionCheck").empty();
	
	if(sv == 1){
		$("#optionCheck").empty();
		str +='<select name = "one">';
		str +='<option value="01" >자유</option>';
		str +='<option value="02" >익명</option>';
		str +='<option value="03" >QnA</option>';
		str +='</select>';
		$("#optionCheck").append(str);
	}else if(sv == 2 || sv == 3 || sv == 4 || sv == 5){
		$("#optionCheck").empty();
		str += '<input type = "text" name = "one">';
		$("#optionCheck").append(str);
	}else if(sv == 6){
		$("#optionCheck").empty();
		str += '<input type = "text" placeholder = "ex)20211111" maxlength = "8" name = "one">';
		str += '<input type = "text" placeholder = "ex)20211111" maxlength = "8" name = "one2">';
		$("#optionCheck").append(str);
	}
}
function search(){
	var sv = $("#selectValue").val();
	var option = $("#option").serialize();
	var one = $("input[name = 'one']").val();
	var one2 = $("input[name = 'one2']").val();
	console.log(one);
	console.log(one2);
	console.log(option);
	var regExp = /^[0-9]*$/;
	
	if(one == "" || one2 ==""){
		alert("빈칸을 채워주세요");
		return
	}	
	
	if(sv == 2 && regExp.test(one) == false){
		alert("숫자만 입력 가능합니다 1");
		return
	}else if(sv == 6 && regExp.test(one) == false){
		alert("숫자만 입력 가능합니다 2");
		return
	}else if(sv == 6 && regExp.test(one2) == false){
		alert("숫자만 입력 가능합니다 3");
		return
	}
	
	var str = "";
	var page ="";
	$.ajax({
		url : './mainOption.ino',
		data : option,
		type : 'post',
		dataType : 'json',
		success : function(data){
			$("#tb").empty();
			$("#page").empty();
			console.log(data.result);
			$.each(data.result, function(index, item){ 
				
				str+='<tr>';
				str+='<td style="width: 20px;" align="center"><input type = "checkbox" value="' + item.num + '" name="Rowcheck"></td>';
				str+='<td style="width: 35px; padding-left: 30px;" align="center">' + item.codeType + '</td>';
				str+='<td style="width: 50px; padding-left: 10px;" align="center">' + item.num + '</td>';
				str+='<td style="width: 125px; "" align="center"><a href="./freeBoardDetail.ino?num=' + item.num + '">' + item.title + '</a></td>';
				str+='<td style="width: 48px; padding-left: 50px;" align="center">' + item.name + '</td>';
				str+='<td style="width: 100px; padding-left: 95px;" align="center">' + item.regdate + '</td>';
				str+='<tr>';
				
			});
			$("#tb").append(str);
			$("#page").append(data.page);
		}, error : function(){
			alert("실패");
		}
	});
	
}


</script>
	<div>
		<h1>자유게시판</h1>
	</div>
	<form id = "option">
	<div>
		<select id= "selectValue" name = "select" onchange="chageLangSelect()">
			<option value="0">전체</option>
			<option value="1">글타입</option>
			<option value="2">글번호</option>
			<option value="3">글제목</option>
			<option value="4">글쓴이</option>
			<option value="5">글내용</option>
			<option value="6">기간</option>
		</select>
		<div id = "optionCheck"></div>
		<input type="button" value="검색" onclick="search()">
		</form>
	</div>
	
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino">글쓰기</a>
	</div>
	<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead>
				<tr>
					<td style="width: 20px;" align="center"><input type = "checkbox" name="Allcheck"></td>
					<td style="width: 35px; padding-left: 30px;" align="center">타입</td>
					<td style="width: 50px; padding-left: 10px;" align="center">글번호</td>
					<td style="width: 125px;" align="center">글제목</td>
					<td style="width: 48px; padding-left: 50px;" align="center">글쓴이</td>
					<td style="width: 100px; padding-left: 95px;" align="center">작성일시</td>
				</tr>
			</thead>
		</table>
	</div>
	<hr style="widt h: 600px;">

	<div>
		<table border="1">
			<tbody id="tb" name="tb">
					<c:forEach var="dto" items="${freeBoardList }">
						<tr>
							<td style="width: 20px;" align="center"><input type = "checkbox" value="${dto.num }" name="Rowcheck"></td>
							<td style="width: 35px; padding-left: 30px;" align="center">${dto.codeType }</td>
							<td style="width: 50px; padding-left: 10px;" align="center">${dto.num }</td>
							<td style="width: 125px; "" align="center"><a href="./freeBoardDetail.ino?num=${dto.num }">${dto.title }</a></td>
							<td style="width: 48px; padding-left: 50px;" align="center">${dto.name }</td>
							<td style="width: 100px; padding-left: 95px;" align="center">${dto.regdate }</td>
						<tr>
					</c:forEach>
			</tbody>
		</table>
		<div id ="page">
			${page}
		</div>
		
	</div>

</body>
</html>