<%@page import="com.mini.page.inventoryPage"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>

<title>재고 목록</title>

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

.InventoryInfoTable {
	border-collapse: collapse;
	border-top: 3px solid #168;
	width: 800px;
	margin-left: auto;
	margin-right: auto;
}

.InventoryInfoTable th {
	color: #168;
	background: #f0f6f9;
	text-align: center;
}

.InventoryInfoTable th, .InventoryInfoTable td {
	padding: 10px;
	border: 1px solid #ddd;
}

.InventoryInfoTable th:first-child, .InventoryInfoTable td:first-child {
	border-left: 0;
}

.InventoryInfoTable th:last-child, .InventoryInfoTable td:last-child {
	border-right: 0;
}

.InventoryInfoTable tr td:first-child {
	text-align: center;
}

.InventoryInfoTable caption {
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

	<%
	int pageNum = Integer.parseInt(request.getParameter("page"));
	String searchType = request.getParameter("searchType")==null?"":request.getParameter("searchType");
	String keyword = request.getParameter("keyword")==null?"":request.getParameter("keyword");

	request.setCharacterEncoding("utf-8");

	String query =
	    "select p_id, p_name, p_unitPrice, p_unitsInStock from product";

	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;

	String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";
	
	int postNum = 5; //한 페이지에 보여질 게시물 갯수 
	int displayPost = (pageNum -1)*postNum; //테이블에서 읽어 올 행의 위치

	if(searchType.equals("p_id")) 
		query += " where p_id like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
	else if(searchType.equals("p_name"))
		query += " where p_name like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
	else if(searchType.equals("p_unitPrice"))
		query += " where p_unitPrice like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
	else if(searchType.equals("p_unitsInStock"))
		query += " where p_unitsInStock like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
	query += " order by p_id desc limit "+ displayPost + "," + postNum;
	
	
	System.out.println("[게시판 목록 보기 쿼리] : " + query);
	%>
	
<script>

function search(){
	
	var searchType = $("#searchType").val();
	var keyword =  $("#keyword").val();
	location.href = 'inventory.jsp?page=<%= pageNum %>&searchType=' + searchType + '&keyword=' + keyword;
}

</script>

<%@include file="/top.jsp"%>
	
	<div class="tableDiv">
		<h1>상품 재고</h1>
		<table class="InventoryInfoTable">
			<tr>
				<th>상품코드</th>
				<th>상품명</th>
				<th>가격</th>
				<th>수량</th>
			</tr>

			<tbody>
<%
	try {
	  //DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
	  //con = ds.getConnection();
	
	  Class.forName("org.mariadb.jdbc.Driver");
	  con = DriverManager.getConnection(uri, uid, pwd);
	
	  stmt = con.createStatement();
	  rs = stmt.executeQuery(query);
	
	  while (rs.next()) {
%>
	<tr onMouseover="this.style.background='#46D2D2';"
		onmouseout="this.style.background='white';">
		<td><%=rs.getString("p_id")%></td>
		<td style="text-align: center;"><a id="hypertext"
			href="/Admin/Inventory/inventoryInfo.jsp?p_id=<%=rs.getString("p_id")%>"
			onMouseover="this.style.textDecoration='
			underline'"
			onmouseout="this.style.textDecoration='none'"><%=rs.getString("p_name")%></a></td>
		<td style="text-align: right;">\ <%=rs.getInt("p_unitPrice")%></td>
		<td><%=rs.getInt("p_unitsInStock")%></td>
	</tr>
<%
	  }
	} catch (Exception e) {
		e.printStackTrace();
		}
		
		if (stmt != null) stmt.close();
		if (rs != null) rs.close();
		if (con != null) con.close();
%>
	</tbody>

</table>
<br>

<div>

	<%
	int listCount = 5; //한 화면에 보여질 페이지 갯수
		int totalCount = 0; //전체 게시물 갯수
		
		try{

			String query_totalCount = "select count(*) as totalCount from product";
			
			if(searchType.equals("p_id")) 
				query_totalCount += " where p_id like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
			else if(searchType.equals("p_name"))
				query_totalCount += " where p_name like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
			else if(searchType.equals("p_unitPrice"))
				query_totalCount += " where p_unitPrice like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
			else if(searchType.equals("p_unitsInStock"))
				query_totalCount += " where p_unitsInStock like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
			
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(uri, uid, pwd);
			  
			stmt = con.createStatement();
			rs = stmt.executeQuery(query_totalCount);
			
			while(rs.next()) totalCount = rs.getInt("totalCount");
		}catch(Exception e){
			e.printStackTrace();
		}
		
		inventoryPage pageList = new inventoryPage();
		
		String pageListView = pageList.getPageList(pageNum, postNum, listCount, totalCount, searchType, keyword);

		if(stmt != null) stmt.close();
		if(rs != null) rs.close();
		if(con != null) con.close();
	%>
	<%=pageListView %>
		</div>
		<br>
	<div>
  		<select id="searchType" name="searchType">
      		<option value="p_id">상품코드</option>
      		<option value="p_name">상품명</option>
      		<option value="p_unitPrice">가격</option>
      		<option value="p_unitsInStock">수량</option>
  		</select>
    	<input type="text" id="keyword" name="keyword" />
  		<button type="button" onclick="search()">검색</button>
 	</div>
<br><br>
		<div class="bottom_menu">
		<a href="/Admin/Inventory/inventory.jsp?page=1">목록으로</a>&nbsp;&nbsp;
			<a href="/index.jsp">홈으로</a>&nbsp;&nbsp;
		</div>
	</div>

	<%@include file="/footer.jsp"%>
</body>
</html>