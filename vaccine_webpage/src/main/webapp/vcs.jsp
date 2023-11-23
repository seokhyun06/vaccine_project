<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "DB.DBConnect" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
	<%
		String sql = "select hospaddr as hosparea," + 
					" case when hospaddr='10' then '서울' when hospaddr='20' then '대전'" + 
					" when hospaddr='30' then '대구' else '광주' end as hospareaname," +
					" count(hospcode) as hospcode" +
					" from tbl_hosp_202108 left join tbl_vaccresv_202108 using(hospcode)" +
					" group by hospaddr" +
					" order by hospaddr";
					
		Connection conn = DBConnect.getConnection();
		PreparedStatement ps = conn.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		int sum = 0;
		
	%>
<html>
<head>
<meta charset="UTF-8">
<title>백신예약현황</title>
<link rel = "stylesheet" href = "css/style.css">
</head>
<body>
<header>
	<jsp:include page ="layout/header.jsp"></jsp:include>
</header>
<nav>
	<jsp:include page ="layout/nav.jsp"></jsp:include>
</nav>
<section class = "section">
<h2>백신예약현황</h2>
	<table border="1" style="margin-left: auto; margin-right: auto; text-align: center;">
		<tr>
			<th>병원지역</th>
			<th>병원지역명</th>
			<th>접종예약건수</th>
		</tr>
		
		<% while(rs.next()) { %>
		<% sum += Integer.parseInt(rs.getString("hospcode"));%>
		<tr>
			<td><%=rs.getString("hosparea") %></td>
			<td><%=rs.getString("hospareaname") %></td>
			<td><%=rs.getString("hospcode") %></td>
		</tr>
			<% } %>
		<tr>
			<td colspan="2">총합</td>
			<td><%= sum%></td>
		</tr>
	</table>
</section>
<footer>
	<jsp:include page ="layout/footer.jsp"></jsp:include>
</footer>
</body>
</html>