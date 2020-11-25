<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인</title>
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
			  	font-size: 18px;
			}
		</style>
	</head>
	
	<body>
		<div class="topnav">
			<div class="dropdown">
				<button class="dropbtn">접속하기</button>
				<div class="dropdown-content">
					<a href="login.jsp">로그인</a>
					<a href="userRegister.jsp">회원가입</a>
				</div>
			</div>
			<a href="main.jsp" style="float:left; font-weight:700;">PlayData</a></li>
			<a href="map.jsp">지도</a>
			<a href="board.jsp">게시판</a>
			<a href="main.jsp">메인</a>
		</div>
		
		<div class="content">
			<h2><b>로그인</b></h2>
			<form action="LoginServlet" method=post>
				<br>
				<label for="loginId">아이디</label>
				<input name="id" class="form-control" label=loginId placeholder="ID"><br>
				<br>
				<label for="loginPw">비밀번호</label>
				<input type="password" name="pw" class="form-control" maxlength='20' size=20 label=loginPw placeholder="Password"><br><br>
				<div id="checkid"></div>
				<input type="submit" value="로그인" class="btn btn-primary form-control" style="width: 160pt; height: 20pt">
				<br><p>
				<a href=findUserId.jsp style="font-size:15px; color:gray" >아이디 찾기</a> 
				<a href=findUserPassword.jsp style="font-size:15px; color:gray" >비밀번호 찾기</a>
				<a href=userRegister.jsp style="font-size:15px; color:gray" >회원가입</a>	
			</form>
		</div>
	</body>
</html>