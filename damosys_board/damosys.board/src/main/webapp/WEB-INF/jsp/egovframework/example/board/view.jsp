<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"		uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring"	uri="http://www.springframework.org/tags" %>
<%
	pageContext.setAttribute("crcn", "\r\n");
	pageContext.setAttribute("br", "<br/>");
%>
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
  $(document).ready(function(){	  	  
	  if(${empty sessionScope.userId}) {		//alert("${sessionScope.userName}");		
		$('#reply').prop("readonly",true);
		$('#id_btnReply').attr("disabled",true);
		$('#id_title_label').text("로그인이 사용자가 아닙니다").css("color", "red");
		
	  }	  
	  else {		  
		  $('#id_title_label').text("${sessionScope.userName}"+"님이 로그인했습니다.");
	  } 
  });
	function list() {
		location.href="<c:url value='/list.do'/>";
	}
	function addReply(){
		if ( $('#writer').val()=='') {
			  alert('작성자을 입력하세요');
			  $('#writer').focus();
			  return false;
		}
		if ( $('#reply').val()=='') {
			  alert('댓글을 입력하세요');
			  $('#reply').focus();
			  return false;
		}		
		if(!confirm("댓글을 작성하겠습니까?")) return false;
		
		document.form2.action="<c:url value='/reply.do'/>?idx=${boardVO.idx}";		                      
		document.form2.submit();
	}
	function mod() {
		location.href="<c:url value='/mgmt.do'/>?mode=mod&idx=${boardVO.idx}";
	}	
	function del() {
		var cnt  = ${fn:length(resultList)};
		if(cnt >0) {
			alert("댓글이 있는 게시물을 삭제할 수 없습니다");
			return;
		}
		if(!confirm("삭제 할까요?")) 
			return;
		document.form1.action ="<c:url value='/mgmt.do'/>?mode=del&idx=${boardVO.idx}";
		document.form1.submit();	
	}	
</script>	
</head>
<body>
<div class="container">
	<h1>상세화면</h1>
	<div class="panel panel-default">
	
		<div class="panel-heading">
			<label for="" id="id_title_label"></label>
		</div>
		
		<div class="panel-body">			
		  <form id="form1" name="form1" class="form-horizontal" method="post" action="">
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="">게시물아이디:</label>
			    <div class="col-sm-10 control-label"  style="text-align:left;">
			      <c:out value="${boardVO.count}"/>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="">타이틀:</label>
			    <div class="col-sm-10 control-label"  style="text-align:left;">
			      <c:out value="${boardVO.title}"/>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">등록자/등록일:</label>
			    <div class="col-sm-10 control-label"  style="text-align:left;">
			    <c:out value="${boardVO.writerName}"/>/<c:out value= "${fn:substring(boardVO.indate,0,fn:length(boardVO.indate)-2)}"/>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="pwd">내용:</label>
			    <div class="col-sm-10 control-label"  style="text-align:left;">
			      <c:out value="${fn:replace(boardVO.contents,crcn,br)}" escapeXml="false"/>
			    </div>
			  </div>
			  			  
			</form>
		</div>
		<div class="panel-footer">
			<c:if test="${!empty sessionScope.userId && sessionScope.userId== boardVO.writer}">
				<button type="button" class="btn btn-default" onclick="mod()">수정</button>
				<button type="button" class="btn btn-default" onclick="del()">삭제</button>			
			</c:if>
			<button type="button" class="btn btn-default" onclick="list()">목록</button>
		</div>
 	</div>
 	
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<div class="well well-sm">
			<c:out value="${result.writer}"/>/<c:out value="${result.indate}"/><br/>			
			<c:out value="${fn:replace(result.reply,crcn,br)}" escapeXml="false"/>
		</div>
 	</c:forEach>
 	
 	<div class="well well-lg">	 	
	 	<form id="form2" name="form2" class="form-horizontal" method="post" action="">
	 		  <div class="form-group">
				    <label class="control-label col-sm-2" for="">작성자/작성일:</label>
				    <div class="col-sm-10 control-label"  style="text-align:left;">
				    <input type="text" class="form-control" id="writer" name="writer" placeholder="작성자를 입력하세요" maxlength=15 style="float:left; width:30%" value="${sessionScope.userName}" readonly>
				      <input type="text" class="form-control" id="indate" name="indate" placeholder="작성일를 입력하세요" maxlength=15  style="float:left; width:30%" readonly value="${strToday}">
				    </div>
			 </div>
			 
		     <div class="form-group">
				    <label class="control-label col-sm-2" for="pwd">댓글:</label>
				    <div class="col-sm-10">
				      <textarea class="form-control" rows="3" id="reply" name="reply" maxlength=300></textarea>
				    </div>
			 </div>
			 <button type="button" id="id_btnReply" class="btn btn-default"   onclick="addReply();">작성</button>
			 	  
	 	</form>
 	</div>
</div>
</body>
</html>