<%@page import="com.mini.page.Page"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>

<title>회원 목록</title>

<style>
body {
	font-family: "나눔고딕", "맑은고딕"
}

h1 {
	font-family: "HY견고딕"
}

a:link {
	color: black;
}

a:visited {
	color: black;
}

a:hover {
	color: red;
}

a:active {
	color: red;
}

#hypertext {
	text-decoration-line: none;
	cursor: hand;
}

.tableDiv {
	text-align: center;
}

.InfoTable {
	border-collapse: collapse;
	border-top: 3px solid #168;
	width: 800px;
	margin-left: auto;
	margin-right: auto;
}

.InfoTable th {
	color: #168;
	background: #f0f6f9;
	text-align: center;
}

.InfoTable th, .InfoTable td {
	padding: 10px;
	border: 1px solid #ddd;
}

.InfoTable th:first-child, .InfoTable td:first-child {
	border-left: 0;
}

.InfoTable th:last-child, .InfoTable td:last-child {
	border-right: 0;
}

.InfoTable tr td:first-child {
	text-align: center;
}

.InfoTable caption {
	caption-side: top;
}

.bottom_menu {
	margin-top: 20px;
}

.bottom_menu>a:link, .bottom_menu>a:visited {
	background-color: #FFA500;
	color: maroon;
	padding: 15px 25px;
	text-align: center;
	display: inline-block;
	text-decoration: none;
}

.bottom_menu>a:hover, .bottom_menu>a:active {
	background-color: #1E90FF;
	text-decoration: none;
}
</style>

</head>

<body>

	<%@include file="/top.jsp"%>
	<%
	request.setCharacterEncoding("utf-8");

	//로그인 창에서 파리미터로 받은 값
	//String userID = request.getParameter("userID");
	//String password = request.getParameter("password");

	//DB에서 사용자 정보(아이디랑 패스워드 가져 오기)
	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";

	int idx = 1;
	%>

	<div class="tableDiv">
		<h1>회원 목록</h1>
		<table class="InfoTable">
			<tr>
				<th>순서</th>
				<th>회원아이디</th>
				<th>회원명</th>
				<th>전화번호</th>
			</tr>

			<tbody>

				<%
				//int pageNum = Integer.parseInt(request.getParameter("page"));

				//int postNum = 5; //한 페이지에 보여질 게시물 갯수 
				//int displayPost = (pageNum -1)*postNum; //테이블에서 읽어 올 행의 위치

				String query = "select * from user";
				//limit "+ displayPost + "," + postNum;

				Connection con = null;
				Statement stmt = null;
				ResultSet rs = null;

				try {

				  Class.forName("org.mariadb.jdbc.Driver");
				  con = DriverManager.getConnection(url, uid, pwd);

				  stmt = con.createStatement();
				  rs = stmt.executeQuery(query);

				  while (rs.next()) {
				%>
				<tr onMouseover="this.style.background='#46D2D2';"
					onmouseout="this.style.background='white';">
					<td><%=idx++%></td>
					<td style="text-align: center;"><a id="hypertext"
						href="/Admin/Member/memberInfo.jsp?userID=<%=rs.getString("userID")%>"
						onMouseover='this.style.textDecoration="underline"'
						onmouseout="this.style.textDecoration='none';"><%=rs.getString("userID")%></a></td>
					<td><%=rs.getString("username")%></td>
					<td><%=rs.getString("telno")%></td>
				</tr>

				<%
				}
				} catch (Exception e) {
				e.printStackTrace();
				}

				if (stmt != null)
				stmt.close();
				if (rs != null)
				rs.close();
				if (con != null)
				con.close();
				%>
			</tbody>

		</table>
		<br>

		<div>

			<%
			/*
				int listCount = 5; //한 화면에 보여질 페이지 갯수
				int totalCount = 0; //전체 게시물 갯수
				
				try{

					String query_totalCount = "select count(*) as totalCount from member";
					
					DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
					con = ds.getConnection();
					
					stmt = con.createStatement();
					rs = stmt.executeQuery(query_totalCount);
					
					while(rs.next()) totalCount = rs.getInt("totalCount");
				}catch(Exception e){
					e.printStackTrace();
				}
				
				Page pageList = new Page();
				
				String pageListView = pageList.getPageList(pageNum, postNum, listCount, totalCount);

				if(stmt != null) stmt.close();
				if(rs != null) rs.close();
				if(con != null) con.close();
				
				pageListView 
				
				*/
			%>
		</div>

		<div class="bottom_menu">
			<a href="/index.jsp">홈으로</a>&nbsp;&nbsp;
		</div>
	</div>
	<%@include file="/footer.jsp"%>
</body>
</html>