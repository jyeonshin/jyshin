<%@page import="mul.cam.food.dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
BbsDto dto = (BbsDto)request.getAttribute("dto");
System.out.println(dto.toString());
%>        

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정 페이지</title>
 <meta name="viewport" content="width=device-width, initial-scale=1">

  <!--  jQuery, bootstrap -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

    <!-- summernote css/js-->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

  <!--  
  <!-- 서머노트를 위해 추가해야할 부분 
  <script src="../summerNote/summernote-lite.js"></script>
  <script src="../summerNote/summernote-ko-KR.js"></script>
  <link rel="stylesheet" href="../summerNote/summernote-lite.css">
   -->
  
</head>
<style>
 body {
 	font-size:18px;
 }
.note-editor {
width:900px;
}
input {
border: none;
border-bottom: 2px solid #ddd;
}
#content-wrapper {
	margin-left:100px;
}
#button-wrapper {
	text-align:center;
	margin-top: 10px;

}
</style>
<body>
<h3>게시글 수정하기</h3>
<div id="content-wrapper">
	<form action="bbsupdateAf.do" id="frm" method="post">
		<input type="hidden" id="seq" name="seq" value="<%=dto.getSeq() %>" >
		<textarea class="summernote" name="thumbnail"><%=dto.getThumbnail() %></textarea>
		<div style="margin-bottom:15px;">
			ID ▶ <input type="text" name="writer" value="<%=dto.getWriter() %>">
		</div>
		<div style="margin-bottom:15px;">
			Title ▶ <input type="text" name="title" id="title" value='<%=dto.getTitle() %>'>
		</div>
		Content ▼ <textarea class="summernote" id="content" name="content"><%=dto.getContent()  %></textarea> 
		<div style="margin-bottom:15px;">
			Ingredients ▶<input type="text" name="ingredients" value='<%=dto.getIngredients() %>'>
		</div>
		<div style="margin-bottom:15px;">
			CookingTime ▶<input type="text" style="text-align:right;" name="cookingtime" value='<%=dto.getCookingtime() %>'>분
		</div>
		<div style="margin-bottom:15px;">
			Servings per container ▶<input type="text" name="serving" value='<%=dto.getServing() %>' style="text-align:right;">인분
		</div>
		<div style="margin-bottom:15px;">
			Category ▶<input type="text" name="category" value='<%=dto.getCategory() %>'>
		</div>
		<div style="margin-bottom:15px;">
			Register Date ▶<input type="text" name="regdate" value="<%=dto.getRegdate() %>" >
		</div>
		<div style="margin-bottom:15px;">
		Stars ▶<input type="text" name="star" value='<%=dto.getStar() %>'>
		</div>
		<div style="margin-bottom:15px;">
		Tags ▶<input type="text" name="tag" value='<%=dto.getTag() %>'>
		</div>
		<div id="button-wrapper">
			<button type="button" id="updateBtn" style="height:35px;" class="btn btn-outline-warning">수정하기</button>
			<button type="button" id="listBtn" style="height:35px;" class="btn btn-outline-warning" onclick="location.href='bbslist.do';">뒤로가기</button>
			<a class="btn btn-outline-warning" id="deleteBtn" style="height:35px;">삭제하기</a>
		</div>
	</form>
</div>

<script>

$('.summernote').summernote({
	  height: 450,
	  lang: "ko-KR"
	});
	
$(document).ready(function() {	
	$("#submitBtn").click(function() {		
		if($("#title").val().trim() == "" ){
			alert("제목을 기입해 주십시오");
			return;
		}else if($("#content").val().trim() == "" ){
			alert("내용을 기입해 주십시오");
			return;
		}else{
			$("#frm").submit();
		}		
	});
	
	/* 수정하기 버튼 */
	$("#updateBtn").on("click", function() {
		$("#frm").submit();
	});
	
	/* 삭제하기 버튼 */
	$("#deleteBtn").on("click", function(){
	    $("#frm").attr("action", "bbsdelete.do");
	    $("#frm").attr("method", "post");
	    $("#frm").submit();
	});

	/* 게시판 목록 (뒤로가기) 이동 버튼 */
	$("#listBtn").on("click", function() {
		$("#listFrm").find("#seq").remove();
		$("#listFrm").attr("action", "bbslist.do");
		$("#listFrm").submit();
	});
	
});
</script>
 
</body>
</html>