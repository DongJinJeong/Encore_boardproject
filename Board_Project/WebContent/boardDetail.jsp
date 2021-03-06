<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.List"%>
<%@page import="encore.board.dao.BoardDAO"%>
<%@page import="encore.board.vo.BoardVO"%>
<%@page import="encore.board.vo.RepleVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시글 세부내용</title>
		<style>
			* {
				box-sizing: border-box;
			  	font-family: Arial, Helvetica, sans-serif;
			}
			body { margin: 0; font-family: Arial, Helvetica, sans-serif; background-image: url('img/bg_1.jpg');	}
			.topnav { overflow: hidden;	background-color: rgba(255,255,255,0); font-size: 18px;}
			.topnav a {
				float: right;
			  	display: block;
			  	color: black;
			  	text-align: center;
			  	padding: 14px 16px;
			  	text-decoration: none;
			}
			.dropdown { float: right; display: inline-block; }
			.dropdown-content {
				display: none;
				position: absolute;
				background-color: #f9f9f9;
				box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
				z-index: 1;
			}
			.dropdown-content a {
				color: black;
				padding: 14px 16px;
				text-decoration: none;
				display: block;
			}
			.dropdown-content a:hover {background-color: #f1f1f1}
			.dropdown:hover .dropdown-content { display: block; }
			.dropbtn {
				background-color: rgba(255,255,255,0);
			  	color: black;
			  	padding: 14px 16px;
			  	font-size: 18px;
			  	border: none;
			  	cursor: pointer;
			}
			.content {
			  	padding: 10px;
			  	height: 400px;
			  	text-align: center;
			  	margin-top: 100px;
			}
		</style>
	</head>
	
	<body>
		<%
			String userID = null;
			if(session.getAttribute("id") != null){
				userID = (String)session.getAttribute("id");
			}
			
			BoardVO boardVO = (BoardVO)request.getAttribute("boardVO"); 
			
			int board_no = boardVO.getBoard_no();
			
			if(board_no == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.')");
				script.println("location.href='board.jsp'");
				script.println("</script>");
			}
			
			List<RepleVO> repleList = (List<RepleVO>) request.getAttribute("repleList");
		%>
		<%
			// 저장된 쿠키 불러오기
			Cookie[] cookieFromRequest = request.getCookies();
			String cookieValue = null;
			for(int i = 0 ; i<cookieFromRequest.length; i++) {
			// 요청정보로부터 쿠키를 가져온다.
				cookieValue = cookieFromRequest[0].getValue();	
			}
	
			if (session.getAttribute(board_no+":cookie") == null) {
			 	session.setAttribute(board_no+":cookie", board_no + ":" + cookieValue);
			} else {
				session.setAttribute(board_no+":cookie ex", session.getAttribute(board_no+":cookie"));
				if (!session.getAttribute(board_no+":cookie").equals(board_no + ":" + cookieValue)) {
				 	session.setAttribute(board_no+":cookie", board_no + ":" + cookieValue);
				}
			}
	 		BoardDAO boardDAO = new BoardDAO();
	 		BoardVO  board = boardDAO.getBoard(board_no);
	
	 		// 조회수 카운트
	 		if (!session.getAttribute(board_no+":cookie").equals(session.getAttribute(board_no+":cookie ex"))) {
	 			boardDAO.updateCount(board);
		 	}
		 	
		 %>
		<div class="topnav">
			<%
				// 로그인이 되어 있지 않다면
				if(userID == null){
			%>
					<div class="dropdown">
						<button class="dropbtn">접속하기</button>
						<div class="dropdown-content">
							<a href="login.jsp">로그인</a>
							<a href="userRegister.jsp">회원가입</a>
						</div>
					</div>
			<%
				} else {
			%>
					<div class="dropdown">
						<button class="dropbtn">회원관리</button>
						<div class="dropdown-content">
							<a href="logout.jsp">로그아웃</a>
							<a href="userUpdate.jsp">정보수정</a>
							<a href="userDelete.jsp">회원탈퇴</a>
						</div>
					</div>
			<%
				}
			%>
			<a href="main.jsp" style="float:left; font-weight:700;">PlayData</a></li>
			<a href="map.jsp">지도</a>
			<a href="board.jsp">게시판</a>
			<a href="main.jsp">메인</a>
		</div>
		
		<div class="content">
			<table class="table table-striped" style="border: 1px solid #dddddd; width: 1000px; height: 50px; margin: auto;">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; font-size: 20px;">게시판 글 보기</th>
						</tr>		
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%=boardVO.getTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replace(">","&gt;").replaceAll("\n","<br>") %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%=boardVO.getUserID() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td><%=boardVO.getReg_date() %></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height: 200px;"><%=boardVO.getContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replace(">","&gt;").replaceAll("\n","<br>") %></td>
						</tr>
						<tr>
							<td>조회수</td>
							<td><%=boardVO.getViews() %></td>
						</tr>
						<tr>
							<td>추천수</td>
							<td><%=boardVO.getLikes() %></td>
						</tr>
					</tbody>
				</table>
				
				<div class="container">
					<div class="row">
					<%
						if(repleList != null) {
					%>
						<table class="table table-striped" style="border: 1px solid #dddddd; width: 1000px; height: 50px; margin: auto;">
							<thead style="background-color: #eeeeee;">
								<tr>
									<th colspan="2" style="background-color: #eeeeee; font-size: 20px;">댓글</th>
								</tr>
								<tr>
									<th style="width: 20%; text-align: center;">작성자</td>
									<th colspan="2" style="text-align: center;">댓글 내용</td>		
								</tr>
							</thead>
							<tbody>
								
					<%
						for(RepleVO repleVO : repleList) {
					%>
								<tr>
									<td style="width: 20%;"><%=repleVO.getUserId() %></td>
									<td colspan="2"><%=repleVO.getContent() %></td>
								</tr>
					<%		
						}
					}
					%>
							</tbody>
						</table>
						<% 
							if(userID != null){
						%>
						<form action="RepleWriteServlet" method="post">
							<table class="table table-striped" style="border: 1px solid #dddddd; width: 1000px; height: 80px; margin: auto;">
								<tbody>
									<tr>
										<input hidden name="boardNo" value=<%=boardVO.getBoard_no() %>>
										<input hidden name="userId" value=<%=userID %>>
										<td><textarea type="text" class="form-control"  placeholder="댓글 내용" name="reple" maxlength="2048" style="height: 80px; width: 1000px;"></textarea></td>
									</tr>
								</tbody>
							</table>
							<input type="submit" class="btn btn-primary pull-right" style="height: 30px; width: 1000px; font-size: 20px;" value="댓글 입력">
						</form>
						<% 
							} else{ 
						%>
						<form action="login.jsp" method="post">
							<table class="table table-striped" style="border: 1px solid #dddddd;">
								<tbody>
									<tr>
										<input hidden name="boardNo" value=<%=boardVO.getBoard_no() %>>
										<input hidden name="userId" value=<%=userID %>>
										<td><textarea type="text" class="form-control" readonly placeholder="댓글을 입력하려면 로그인을 하세요" name="reple" maxlength="2048" style="height: 50px;"></textarea></td>
									</tr>
								</tbody>
							</table>
							<input type="submit" class="btn btn-primary pull-right" value="로그인">
						</form>
						<%
							}
						%>
					</div>
				</div>
				<p>
				
				<a href="board.jsp"><button style="font-size: 16px;">목록</button></a>
				<%
					if(userID != null && userID.equals(boardVO.getUserID())){
				%>
						<a href="boardUpdateForm.jsp?board_no=<%=board_no %>"><button style="font-size: 16px;">수정</button></a>
						<a href="boardDelete.jsp?board_no=<%=board_no %>"><button style="font-size: 16px;">삭제</button></a>
				<%
					}else{
				%>
						<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?board_no=<%=board_no %>" class="btn btn-danger"><button style="font-size: 16px;">추천</button></a>
				<%
					}
				%>
		</div>
	</body>
</html>