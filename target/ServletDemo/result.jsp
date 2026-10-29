<%@ page import="java.sql.*" %>
<%@ page import="com.bus.DBConnection" %>
<html>
<head>
<title>School Bus Route Register Result</title>
</head>
<body>
<h2 align="center">Saved! All Records</h2>
<%
    String student = request.getParameter("student");
    String stop = request.getParameter("stop");
    String route = request.getParameter("route");
    String fee = request.getParameter("fee");
    if (student != null && fee != null) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO bus_route (student, stop, route, fee) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, student);
            ps.setString(2, stop);
            ps.setString(3, route);
            ps.setInt(4, Integer.parseInt(fee));
            ps.executeUpdate();
            con.close();
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
    String filter = request.getParameter("filterRoute");
%>
<form method="get" action="result.jsp">
    Filter by Route: 
    <select name="filterRoute">
        <option value="">All Routes</option>
        <option value="Route 1" <% if("Route 1".equals(filter)) out.print("selected"); %>>Route 1</option>
        <option value="Route 2" <% if("Route 2".equals(filter)) out.print("selected"); %>>Route 2</option>
        <option value="Route 3" <% if("Route 3".equals(filter)) out.print("selected"); %>>Route 3</option>
    </select>
    <input type="submit" value="Show">
</form>
<br>
<table border="1" cellpadding="8" cellspacing="0" width="100%">
    <tr bgcolor="#cccccc">
        <th>ID</th>
        <th>Student</th>
        <th>Stop</th>
        <th>Route</th>
        <th>Monthly Fee</th>
    </tr>
<%
    int totalRecords = 0;
    try {
        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();
        String query;
        if (filter != null && !filter.isEmpty()) {
            query = "SELECT * FROM bus_route WHERE route = '" + filter + "'";
        } else {
            query = "SELECT * FROM bus_route";
        }
        ResultSet rs = st.executeQuery(query);
        while (rs.next()) {
            totalRecords++;
%>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("student") %></td>
        <td><%= rs.getString("stop") %></td>
        <td><%= rs.getString("route") %></td>
        <td><%= rs.getInt("fee") %></td>
    </tr>
<%
        }
        con.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='5'>Error loading records: " + e.getMessage() + "</td></tr>");
    }
%>
</table>
<table border="1" cellpadding="8" cellspacing="0" width="100%" style="margin-top: -1px;">
    <tr>
        <td><b>Total records:</b> <%= totalRecords %></td>
    </tr>
</table>
<br>
<a href="index.html">Register Another Student</a>
</body>
</html>