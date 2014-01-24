<%@page import="org.wso2.appserver.samples.saas.AuthenticationUtils" %>
<%@ page import="org.wso2.carbon.user.api.UserRealmService" %>
<%@ page import="org.wso2.carbon.context.PrivilegedCarbonContext" %>
<%@ page import="org.apache.catalina.mbeans.UserMBean" %>
<%@ page import="org.wso2.appserver.samples.saas.UserMgtUtils" %>
<%@ page import="org.wso2.carbon.user.api.UserStoreException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
</head>
<body>

<%
    int tenantID = (Integer) session.getAttribute("tenantID");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && username.trim().length() > 0) {
        if (!UserMgtUtils.checkExistingTenantUser(username, tenantID)) {
            UserMgtUtils.addTenantUser(username, password, tenantID);
        } else {
%>
<p>
    The user: <%=username%> already exists
</p>
<%
        }
    }
%>

<form action="index.jsp">
    <table>
        <tr>
            <td>Username</td>
            <td><input type="text" name="username"/></td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input type="text" name="password"/></td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td><input type="submit" value="Add"/></td>
        </tr>
    </table>
</form>

<p>
    <b>Available Users List</b>
</p>
<%
    String[] names = new String[0];
    try {
        names = UserMgtUtils.getTenantUserNames(tenantID);
    } catch (UserStoreException e) {
        e.printStackTrace();  //Todo : handle error gracefully
    }
    for (String name : names) {
%><%=name%><br/>
<%
    }
%>
</body>
</html>