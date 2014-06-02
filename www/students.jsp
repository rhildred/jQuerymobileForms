<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="ca.on.conestogac.*"%>
<%@page import="java.sql.*"%>
<%

try{
	Connection oConnection = OpenShiftDataSource.getConnection(
			getServletContext().getInitParameter("the.db"));
	Statement oStmt = oConnection.createStatement();
	String sSQL = "SELECT * FROM students";
	ResultSet oRs = oStmt.executeQuery(sSQL);
	%><table border="1"><%
	ResultSetMetaData resMetaData =oRs.getMetaData();
	int nCols = resMetaData.getColumnCount();
	%><tr><%
	for (int kCol = 1; kCol <= nCols; kCol++){
		out.println("<td><b> + resMetaData.getColumn(kCol)</b></td>");
	}
	%></tr><%
	while (oRs.next()) {
		%><tr><%
		for (int kCol = 1; kCol <= nCols; kCol++) {
		      out.print("<td>" + oRs.getString(kCol) + "</td>");
		      }
		%></tr><%
	}
			%></table>
			conn.close();
	<%		
	//out.println(ResultSetValue.toJsonString(oRs));
}
catch(Exception e)
{
	out.println(e.toString());
}


%>