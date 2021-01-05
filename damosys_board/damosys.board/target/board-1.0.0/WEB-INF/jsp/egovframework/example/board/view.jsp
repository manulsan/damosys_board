<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"		uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring"	uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
	<title>Listview.jsp</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<c:url value='/css/bootstrap/css/bootstrap.min.css'/>">
	  <script src="<c:url value='/js/jquer-3.5.1y.min.js'/>"></script>
	  <script src="<c:url value='/css/bootstrap/js/bootstrap.min.js'/>"></script>
	  	
</head>  <script>
	  function list() {
		  location.href="<c:url value='/list.do'/>";
	  }	  
	  </script>	
<body>
<div class="container">
	<h1>상세화면</h1>
	<div class="panel panel-default">
		<div class="panel-heading">
			<label for="">안녕하세요?</label>
		</div>
		<div class="panel-body">			
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="idx">게시물아이디:</label>
			    <div class="col-sm-10 control-label"  style="text-align:left;">
			      게시물아이디:
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">Password:</label>
			    <div class="col-sm-10 control-label"  style="text-align:left;">
			      제목
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">등록자/등록일:</label>
			    <div class="col-sm-10 control-label"  style="text-align:left;">
			    등록자/등록일
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">Password:</label>
			    <div class="col-sm-10 control-label"  style="text-align:left;">
			      내용
			    </div>
			  </div>
			  
			  			  
			
		</div>
		<div class="panel-footer">
		<button type="button" class="btn btn-default">수정</button>
		<button type="button" class="btn btn-default">삭제</button>		
		<button type="button" class="btn btn-default" onclick="list()">목록</button>
		</div>
 	</div>
 	<div class="well well-sm">작성자/작성일/내용</div>
 	<div class="well well-lg">
 	<form class="form-horizontal" method="ppst" action="replay.do">
 		  <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">작성자/작성일:</label>
			    <div class="col-sm-10 control-label"  style="text-align:left;">
			    <input type="password" class="form-control" id="writer" name="writer" placeholder="등록자를 입력하세요" maxlength=15 style="float:left; width:30%">
			      <input type="password" class="form-control" id="indate" name="indate" placeholder="등록일를 입력하세요" maxlength=15  style="float:left; width:30%">
			    </div>
		 </div>
		 
	     <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">댓글:</label>
			    <div class="col-sm-10">
			      <textarea class="form-control" rows="3" id="replay" name="replay" maxlength=300> </textarea>
			    </div>
		 </div>
		 <button type="submit" class="btn btn-default">작성</button>
		 "댓글은 수정이나 삭제를 할수없습니다.!!!"	  
 	</form>
 	</div>
</div>
</body>
</html>