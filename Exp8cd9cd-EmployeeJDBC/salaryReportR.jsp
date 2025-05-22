<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Salary Report - Emp Name Starting with Input</title>
    <style>
        body {
            font-family: monospace;
        }
        .line {
            border-top: 1px solid #000;
            margin: 10px 0;
        }
    </style>
</head>
<body>
<h2>Salary Report - Filter by Starting Letter</h2>
<form method="post">
    Enter starting letter: <input type="text" name="start" maxlength="1" required />
    <input type="submit" value="Generate Report" />
</form>

<%
    String start = request.getParameter("start");
    if (start != null && !start.trim().isEmpty()) {
        int grandTotal = 0;
%>
<pre>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    Salary Report
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Employee", "root", "");
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Emp WHERE Emp_Name LIKE ?");
            ps.setString(1, start + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int no = rs.getInt("Emp_NO");
                String name = rs.getString("Emp_Name");
                int salary = rs.getInt("Basicsalary");
                grandTotal += salary;
%>
Emp_No    : <%= no %>  
Emp_Name  : <%= name %>  
Basic     : <%= salary %>  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<%
            }
            conn.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
%>
Grand Total Salary = <%= grandTotal %>  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</pre>
<% } %>
</body>
</html>
