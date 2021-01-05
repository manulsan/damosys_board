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
	  
	  <script>
	  function list() {
		  location.href="<c:url value='/list.do'/>";
	  }	  
	  </script>		
</head>
<body>
<div class="container">
	<h1>등록/수정화면</h1>
	<div class="panel panel-default">
		<div class="panel-heading">
			<label for="">뭐지?</label>
		</div>
		<div class="panel-body">
			<form class="form-horizontal" method="post" action="/mgmt.do">
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="idx">게시물아이디:</label>
			    <div class="col-sm-10">
			      <input type="email" class="form-control" id="idx" name="idx" placeholder="자동입력">
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">Password:</label>
			    <div class="col-sm-10">
			      <input type="password" class="form-control" id="title" name="title" placeholder="제목을 입력하세요" maxlength=100>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">등록자/등록일:</label>
			    <div class="col-sm-10">
			      <input type="password" class="form-control" id="writer" name="writer" placeholder="등록자를 입력하세요" maxlength=15 style="float:left; width:30%">
			      <input type="password" class="form-control" id="indate" name="indate" placeholder="등록일를 입력하세요" maxlength=15  style="float:left; width:30%">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">Password:</label>
			    <div class="col-sm-10">
			      <textarea class="form-control" rows="5" id="contents" name="contents" maxlength=1000> </textarea>
			    </div>
			  </div>
			  
			  			  
			</form>
		</div>
		<div class="panel-footer">
		<button type="button" class="btn btn-default">등록</button>
		<button type="button" class="btn btn-default">수정</button>		
		<button type="button" class="btn btn-default" onclick="list()">취소</button>
		</div>
 	</div>
</div>
</body>
</html>