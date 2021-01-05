<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<script src="<c:url value='/js/jquery-3.5.1.min.js'/>"></script>
<script src="<c:url value='/css/bootstrap/js/bootstrap.min.js'/>"></script>	  
<script>	  
	$(document).ready(function() {
		$('#idx').prop('readonly',true);
		$('#writerName').prop('readonly',true);
		$('#indate').prop('readonly', true);
	});
	  
	function add() {
		if($('#title').val() =='') {
			alert("제목을 입력하세요");
			$('#title').focus();
			return;
		}
		if($('#contents').val() =='') {
				alert("내용을 입력하세요");
				$('#title').focus();
				return;
		}		
		if(!confirm("등록할까요?")) 
			return;
		document.form1.action ="<c:url value='/mgmt.do'/>?mode=add";
		document.form1.submit();
	}
	function list() {
		  location.href="<c:url value='/list.do'/>";
	}	  
	function mod() {
		if($('#title').val() =='') {
			alert("제목을 입력하세요");
			$('#title').focus();
			return;
		}
		if($('#contents').val() =='') {
				alert("내용을 입력하세요");
				$('#title').focus();
				return;
		}		
		if(!confirm("수정 할까요?")) 
			return;
		document.form1.action ="<c:url value='/mgmt.do'/>?mode=mod";
		document.form1.submit();
	}
	
	  </script>		
</head>
<body>
<div class="container">
	<h1>등록/수정화면</h1>
	<div class="panel panel-default">
		<div class="panel-heading">
			<label for="">안녕하세요?</label>
		</div>
		<div class="panel-body">
			<form id="form1" name="form1" class="form-horizontal" method="post" enctype="Multipartaction/form-data" action="/mgmt.do">
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="idx">게시물아이디:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="idx" name="idx" placeholder="자동입력" value="${boardVO.idx}">			      
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">제목:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요" maxlength=100 value="${boardVO.title}">
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">등록자/등록일:</label>
			    <div class="col-sm-10">
			      <input type="hidden" class="form-control" id="writer" name="writer" placeholder="등록자를 입력하세요" maxlength=15 style="float:left; width:30%" value= "${boardVO.writer }">
			      <input type="text" class="form-control" id="writerName" name="writerName" placeholder="등록자를 입력하세요" maxlength=15 style="float:left; width:30%" value= "${boardVO.writerName}">
			      <c:set var="indate" value="${boardVO.indate }"/>
			      <c:if  test="fn:length(indate) >8">
			      	<c:set var="indate" value="${fn:substring(indate,0,fn:length(indate)-2)}"/>
			      </c:if>			      
			      <input type="text" class="form-control" id="indate" name="indate" placeholder="등록일를 입력하세요" maxlength=15  style="float:left; width:30%" value= "<c:out value='${indate}'/>">
			    </div>
			  </div>			
			   <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">내용:</label>
			    <div class="col-sm-10">
			      <textarea class="form-control" rows="5" id="contents" name="contents" maxlength=1000>${boardVO.contents}</textarea>
			    </div>
			  </div>
			  
			    <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">점부파일:</label>
			    <div class="col-sm-10">
			      <input type="file" class="control-label" id="file" name="file">
			    </div>
			  </div>
			  
			  			  
			</form>
		</div>
		<div class="panel-footer">
		<c:if test="${!empty sessionScope.userId }">
			<c:if test="${empty boardVO.idx}">
				<button type="button" class="btn btn-default" onclick="add()">등록</button>
			</c:if>
			<c:if test="${!empty boardVO.idx}">		
				<button type="button" class="btn btn-default" onclick="mod()">수정</button>
			</c:if>
		</c:if>		
		<button type="button" class="btn btn-default" onclick="list()">취소</button>
		</div>
 	</div>
</div>
</body>
</html>