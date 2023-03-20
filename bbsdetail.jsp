<%@page import="mul.cam.food.dao.MemberDao"%>
<%@page import="mul.cam.food.dto.MemberDto"%>
<%@page import="mul.cam.food.dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%
 	MemberDto login = (MemberDto)session.getAttribute("login");
	BbsDto dto = (BbsDto)request.getAttribute("bbsdto");
	String uploadFilePath = (String)request.getAttribute("uploadFilePath");

%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<title>상세글 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="./css/bbsdetail.css" >
<link rel="stylesheet" href="./images/favicon.ico">
<style type="text/css">
	#writer {
		border:none;
		border-bottom:2px solid #ddd;
		margin-bottom:10px;
	}
	textarea {
		border:1px solid #ddd;
	} 
	
</style>
</head>
<body>

<!-- 상단 내비게이션 -->
        <nav role="navigation" style="background: lightgoldenrodyellow;">
            <img src="./images/logo.png" id="logo-img" width="150px" height="90px">
            <ul id="main-menu nav-pills">
                <li class="left-tab slide"><a href="#" style="margin-left:27px;">카테고리</a>
                    <ul id="sub-menu">
                        <li><a href="#" aria-label="submenu">한식</a></li>
                        <li><a href="#" aria-label="submenu">중식</a></li>
                        <li><a href="#" aria-label="submenu">일식</a></li>
                        <li><a href="#" aria-label="submenu">양식</a></li>
                    </ul>
                </li>
                <li class="left-tab"><a href="bbslist.do" style="margin-left:27px;">게시판</a></li>
                <li class="right-tab"><a href="regi.do">회원가입</a></li>
                <li class="right-tab"><a href="login.do">로그인</a></li>
            </ul>
        </nav>
        
     <main class="container">
	  <div class="p-4 p-md-5 mb-4 rounded text-bg-dark">
	    <div class="col-md-6 px-0" style="width:900px; height:500px;">
	    	<%=dto.getThumbnail() %>
	     	<input type="hidden", name="thumbnail" value='<%=dto.getThumbnail() %>' >
	    	<div id="thumimg" th:utext="<%=dto.getThumbnail() %>"></div>
	    </div>
	  </div>

	  <div class="row g-5">
	    <div class="col-md-8">
	     	
	      <article class="blog-post">
	        <h2 class="blog-post-title mb-1" id="title"><%=dto.getTitle() %></h2>
	        <p class="blog-post-meta">작성자 : <%=dto.getWriter() %></p>
			<p class="blog-post-meta">작성일 : <%=dto.getRegdate() %></p>
	        <pre id="content"><%=dto.getContent() %></pre>
	        <hr>
	        
	        <h2>댓글 목록</h2>
	        <table class="table" style="border:none;">
	          <thead>
	            <tr>
	              <th style="width:200px;">작성자</th>
	              <th>내용</th>
	            </tr>
	          </thead>
	          <tbody id="tbody">
	            <tr>
	            	<td> <a href="">수정</a> / <a href="">삭제</a> </td>
	            </tr>
	          </tbody>
	        </table>
	       </article>
	      <br>  	        
	      <article class="blog-post">
	        <h2 class="blog-post-title mb-1">댓글 입력하기</h2>
	        <form action="commentWriteAf.do" method="post">
	        	<input type="hidden" name="seq" id="seq" value="<%=dto.getSeq() %>"> 
	         		<p>
	         			<label>댓글 작성자</label> <input type="text" name="writer" style="border:1px solid rgba(224, 223, 226, 0.6); border-radius:30px;"> 
	         		</p>
	        		<p>
		        	<textarea rows="8" cols="100" name="content"></textarea>
		        	</p>
		        	
		         <p>무분별한 댓글은 삭제조치 될 수 있으니 이점 양해 부탁드립니다.</p>
		         
		         <div style="text-align:center; width:742px; margin-top:20px;">
		        	<button type="submit" style="border:none; background:#fafad2; color:#333; width:100px; height:37px;">전송하기</button>
		        	<button type="button" onclick="location.href='bbslist.do'" style="border:none; background:#fafad2; color:#333; width:100px; height:37px;">목록으로</button>
	        		<button type="button" style="border:none; background:#fafad2; color:#333; width:100px; height:37px;" id="updateBtn">수정하기</button>
	        	</div>
	        </form>
	      </article>
    	</div>
		
		<!-- 사이드 메뉴 재료부터 태그까지 -->
	    <div class="col-md-4" style="background:lightgoldenrodyellow; border-radius:12px; color:#333;">
	      <div class="position-sticky" style="top: 2rem;">
	        <div class="p-4 mb-3 bg-light rounded">
	          <h4 class="fst-italic">재료</h4>
	          <p class="mb-0"><%=dto.getIngredients() %></p>
	        </div>
			<br>
	        <div class="p-4">
	          <h4 class="fst-italic">조리시간</h4>
	          <p class="mb-0"><%=dto.getCookingtime() %></p>
	        </div>
			<br>
	        <div class="p-4">
	          <h4 class="fst-italic">Servings</h4>
          	  <p class="mb-0"><%=dto.getServing() %> 인분</p>
        	</div>
        	<br>
        	<div class="p-4">
	          <h4 class="fst-italic">별점</h4>
          	  <p class="mb-0"><%=dto.getStar() %> 점</p>
        	</div>
        	<br>
        	<div class="p-4">
	          <h4 class="fst-italic">태그</h4>
          	  <p class="mb-0"><%=dto.getTag() %></p>
        	</div>
      	  </div>
    	</div>
  </div>

</main>
        
        <!-- 하단 푸터 -->
        <footer>
            <p> Copyright © 2023. MultiCampus. </p>
        </footer>


	<script type="text/javascript">
  	$('#summernote').summernote({
		height: 300,
		width : 1000,
		minHeight: null,
		maxHeight: null,
		focus: true,
		lang: "ko-KR",
		callbacks: {
			onImageUpload : function(files){
				sendFile(files[0],this);
			}
		}
			
	});
  	
  	$(document).ready(function(){

  		$("#updateBtn").click(function(){

  			var form = document.createElement('form');

  			var objs;

  			objs = document.createElement('input');

  			objs.setAttribute('seq', seq);

  			form.appendChild(objs);

  			form.setAttribute('method', 'post');

  			form.setAttribute('action', "/bbsupdate.do");

  			document.body.appendChild(form);

  			form.submit();

  		});	

  		});	
  	
  	$("#updateBtn").click(function(){
  		location.href="bbsupdate.do?seq="+$('#seq').val();
  		
  	});
	
		/*이미지 태그 추출*/
	$(function getImageByTagName(){
	    const dbValue = document.getElementById('thumimg');
	    const tag = dbValue.getElementsByTagName('img');
	    const tagLength = tag.length;
	    if(tag.length>=1){
	        for(let i=0; i<tagLength; i++){
	            $(".contentImg").append(tag[0]);
	        }
	    }else if(tag.length==0){
	        $(".contentImg").append('<img src="/images/no_image.png">');
	    }
	});

	 function setThumbnail(event) {
	        var reader = new FileReader();

	        reader.onload = function(event) {
	          var img = document.createElement("img");
	          img.setAttribute("src", event.target.result);
	          document.querySelector("div#thumimg").appendChild(img);
	        };

	        reader.readAsDataURL(event.target.files[0]);
	      }
	
		$(document).ready(function() {
			$.ajax({
				url:"./commentList.do",
				type:"get",
				data: {"seq" : <%=dto.getSeq() %>},
				success:function(list){
					alert('성공적으로 댓글이 작성되었습니다');
					
					$("#tbody").html("");
					
					$.each(list, function(index, item){
						let str = "<tr>"
								+	"<td style='width:200px;'>" + item.writer + "</td>"
								+	"<td>" + item.content + "</td>"
								+ "</tr>";
						$("#tbody").append(str);
					});
				},
				error:function() {
					alert('오류가 발생했습니다');
				}
			});
		
		});

	</script>
	<script>

  $.ajax({
	  url: "bbsdetail.do?seq="+ <%=dto.getSeq() %> ,
	  success: function(result){
		$("#image").append('<img src="./resources/images'+ result.thumbnail + '" style="width: 100%;">');
		$("#title").text(result.title);
		$("#content").text(result.content);
   }});
  

		
	function sendFile(file, editor){
		var data = new FormData();
		data.append("file", file);
		console.log(file);
		$.ajax({
			data : data,
			type : "POST",
			url : "SummerNoteImageFile",
			contentType : false,
			processData : false,
			success : function(data){
				console.log(data);
				console.log(editor);
				$(editor).summernote("insertImage",data.url);
			}
		});
	}

  </script>
</body>
</html>