<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.mini.client.Product"%>
<%@ page import="com.mini.client.ProductRepository"%>

<html>
<head>
<link rel ="stylesheet" href ="./resources/css/bootstrap.min.css" />
<title>어서 오세요</title>
</head>
<body>
	<jsp:include page="top.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품목록</h1>
		</div>
	</div>
	<%
		ProductRepository client = ProductRepository.getInstance();
		ArrayList<Product> listOfProducts = client.getAllProducts();
	%>

	<div class="container">
		<div class="row" align="center">
			<%
				for (int i = 0; i < listOfProducts.size(); i++) {
					Product product = listOfProducts.get(i);
			%>
			<div class="col-md-4">
				<img src ="resources/images/<%=product.getFilename()%>" style ="width: 100%">
				<h3><%=product.getP_name()%></h3>
				<p><%=product.getDescription()%>
				<p><%=product.getP_price()%>원
				<p><a href="./product.jsp?id=<%=product.getP_id()%>" class="btn btn-secondary" role="button"> 상세 정보 &raquo;</a>
			</div>
			<%
				}
			%>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
