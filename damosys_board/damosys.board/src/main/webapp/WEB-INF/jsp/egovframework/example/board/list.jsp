<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	$(document).ready( function() {		
		<c:if test="${!empty msg}">
			alert("${msg}");
		</c:if>
	});
	function add() {
		  location.href="<c:url value='/mgmt.do'/>?mode=add";
	}
	function view(pIDX) {
		  location.href="<c:url value='/view.do'/>?idx="+pIDX;		  
	}	  
	function setPwd(user_id) {
		  if(user_id =="admin") 		$('#password').val('admin');
		  else if(user_id =="guest") 	$('#password').val('guest');
		  else if(user_id =="guest2") 	$('#password').val('guest2');
	}	  
	function checkVal() {
		if ( $('#user_id').val()=='') {
			  alert('아이디를 입력하세요');
			  return false;
		}
		if ( $('#password').val()=='') {
				  alert('비밀번호를 입력하세요');
				  return false;
		}
		return true;
	}
	function out() {
		location.href ="<c:url value='/logout.do'/>";
		
	}	
	
	  /* pagination 페이지 링크 function */
    function fn_egov_link_page(pageNo){
    	//document.listForm.pageIndex.value = pageNo;
    	//document.listForm.action = "<c:url value='/egovSampleList.do'/>";
    	location.href = "<c:url value='/list.do'/>?pageIndex="+pageNo;
       	document.listForm.submit();
    }
</script>	
</head>
<body>
<div class="container">
	<h1>메인 화면</h1>
	<div class="panel panel-default">
		<div class="panel-heading">
		<c:if test="${sessionScope == null || sessionScope.userId ==null || sessionScope.userId==''}">
		
		<form class="form-inline" method="post" action="<c:url value='/login.do'/>">
			  <div class="form-group">
			    <label for="user_id">ID :</label>
			    <select class="form-control" id="user_id" name="user_id" onchange="setPwd(this.value)">
			    	<option value="">선택하세요</option>
				    <option value="admin">관리자</option>
				    <option value="guest">사용자</option>
				    <option value="guest2">사용자2</option>				    
				</select>
			  </div>
			  <div class="form-group">
			    <label for="password">Password:</label>
			     <input type="password" class="form-control" id="password" name="password">
			  </div>
			  <button type="submit" class="btn btn-default" onclick="return checkVal()">로그인</button>
			</form>
			</c:if>
			
		<c:if test="${sessionScope != null &&  sessionScope.userId !=null &&  sessionScope.userId!=''}">
		
		  ${sessionScope.userName}=환영합니다.
		  <button type="button" class="btn btn-default" onclick="out()">로그아웃</button>
		</c:if>
		
		
		</div>
		<div class="panel-body">
		<form class="form-inline" method=" <c:url value='/list.do'/>">
			  <div class="form-group">
			    <label for="searchKeyword">제목(내용):</label>
			    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword">
			  </div>			  
			  <button type="submit" class="btn btn-default">검색</button>
		</form>
		 <div class="table-responsive">          
			  <table class="table table-hover">
			    <thead>
			      <tr>
			        <th>게시물 번호</th>
			        <th>제목</th>
			        <th>조회수</th>
			        <th>파일</th>
			        <th>등록자</th>
			        <th>등록일</th>			        
			      </tr>
			    </thead>
			    <tbody>
			    <c:forEach var="result" items="${resultList}" varStatus="status">
			      <tr>
			        <td><a href="javascript:view('${result.idx}');"> <c:out value="${result.idx}"/> </a></td>
			        <td><a href="javascript:view('${result.idx}');"> <c:out value="${result.title}"/></a></td>
			        <td> <c:out value="${result.count}"/></td>
			        <td> <c:out value="${result.reply}"/></td>
			        <td> 
			        	<c:if test="${result.filenmae !=''}">
			        	 <span class="glyphicon glyphicon-file"> <c:out value="${result.filename}"/></span>
			        	</c:if>
			        		 
			        </td>
			        <td> <c:out value="${result.writerName}"/></td>
			        <%-- <td> <c:out value="${result.indate}" pattern="yyyy-MM-dd hh:mm:ss"/></td> --%>
			        <td> <fmt:formatDate value="${result.indate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
			        
			      </tr>
			    </c:forEach>
			    </tbody>
			  </table>
			  </div>
			<div id="paging" align="center">			
				<ul class="pagination">
					<span class="badge">${paginationInfo.totalRecordCount}</span>					
					<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
				</ul>
        		<%-- <form:hidden path="pageIndex" /> --%>
        	</div>
		</div>
		<div class="panel-footer">
			<c:if test="${!empty sessionScope.userId }">
				<button type="button" class="btn btn-default" onclick="add()">등록</button>
			</c:if>
		</div>
 	</div>
</div>
</body>
</html>