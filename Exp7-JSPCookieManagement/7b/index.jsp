<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cookie List Management</title>
    <style>
        .cookie-table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px 0;
        }
        .cookie-table th, .cookie-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .cookie-table th {
            background-color: #f2f2f2;
        }
        .form-section {
            margin-top: 20px;
        }
        .form-section input[type="text"],
        .form-section input[type="number"] {
            width: 200px;
            padding: 5px;
        }
        .form-section label {
            display: inline-block;
            width: 140px;
        }
        .auto-refresh {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
    </style>
    <script>
        // Auto refresh page every 60 seconds to update cookie list
        setTimeout(function () {
            window.location.reload();
        }, 60000);
    </script>
</head>
<body>

<h2>Cookie List Management</h2>

<!-- Form to set cookies -->
<div class="form-section">
    <h3>Set New Cookie</h3>
    <form action="setCookie.jsp" method="post">
        <p>
            <label for="cookieName">Cookie Name:</label>
            <input type="text" name="cookieName" id="cookieName" required>
        </p>
        <p>
            <label for="domain">Domain:</label>
            <input type="text" name="domain" id="domain" required>
        </p>
        <p>
            <label for="maxAge">Max Age (seconds):</label>
            <input type="number" name="maxAge" id="maxAge" value="10" required>
        </p>
        <p>
            <input type="submit" value="Add Cookie">
        </p>
    </form>
</div>

<hr>

<!-- Display list of set cookies -->
<h3>List of Active Cookies</h3>
<p class="auto-refresh">List updates automatically when cookies expire</p>

<table class="cookie-table">
    <thead>
    <tr>
        <th>Cookie Name</th>
        <th>Domain</th>
        <th>Max Age (seconds)</th>
    </tr>
    </thead>
    <tbody>
    <%
        @SuppressWarnings("unchecked")
        List<Map<String, String>> cookieList = (List<Map<String, String>>) session.getAttribute("cookieList");
        long currentTime = System.currentTimeMillis() / 1000;

        if (cookieList != null) {
            Iterator<Map<String, String>> iterator = cookieList.iterator();
            while (iterator.hasNext()) {
                Map<String, String> cookie = iterator.next();
                long setTime = Long.parseLong(cookie.get("setTime"));
                int maxAge = Integer.parseInt(cookie.get("maxAge"));
                if (currentTime > setTime + maxAge) {
                    iterator.remove(); // Remove expired
                }
            }
            session.setAttribute("cookieList", cookieList);
        }

        if (cookieList != null && !cookieList.isEmpty()) {
            for (Map<String, String> cookie : cookieList) {
    %>
    <tr>
        <td><%= cookie.get("name") %></td>
        <td><%= cookie.get("domain") %></td>
        <td><%= cookie.get("maxAge") %></td>
    </tr>
    <%
            }
        } else {
    %>
    <tr>
        <td colspan="3" style="text-align: center;">No active cookies</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

</body>
</html>
