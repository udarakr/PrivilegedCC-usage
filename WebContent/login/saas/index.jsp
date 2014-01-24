<%@ page import="org.wso2.appserver.samples.saas.TenantUtils" %>
<%@ page import="org.wso2.carbon.utils.multitenancy.MultitenantUtils" %>
<%@ page import="org.wso2.carbon.user.api.UserStoreException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>SaaS CarbonContext usage</title>
</head>
<body>
<%
    String fq_username = request.getRemoteUser();
    String tenantDomain = MultitenantUtils.getTenantDomain(fq_username);

    int tenantID = 0;
    try {
        tenantID = TenantUtils.getTenantId(tenantDomain);
    } catch (UserStoreException e) {
        e.printStackTrace();  //Todo handle error
    }

    session.setAttribute("tenantID", tenantID);
    session.setAttribute("tenantDomain", tenantDomain);
%>

<a href="../../logout/logout.jsp">Log-out</a>
<p>
You are logged in as <% out.print(fq_username);%></br>
You are belonged to tenant <% out.print(tenantDomain);%></br>
Tenant ID : <% out.print(tenantID);%></br>
</p>
</body>
</html>
