
<%@page import="com.subsystem.request.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.mashape.unirest.http.Unirest"%>
<%@page import="com.mashape.unirest.http.HttpResponse"%>
<%@page import="com.subsystem.servlet.WebReponse"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
         <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
        <title>User Attendance Report</title>
    </head>
    <body>

        <h3 align="center">User Attendance Report</h3>
     

        <%
            HttpResponse<WebReponse> userAttendanceResponse = Unirest.get("http://localhost:8080/ams/api/attendance/getAllUser/")
                    .header("accept", "application/json")
                    .header("Content-Type", "application/json")
                    .asObject(WebReponse.class);
            WebReponse wr = userAttendanceResponse.getBody();
            System.out.println("----- " + wr.getResponseData()+"   "+(wr.getResponseData() instanceof HashMap));
            if (wr.getResponseData() instanceof List) {
//                HashMap mwResponse = (HashMap) userAttendanceResponse.getBody().getResponseData();
                List usersList=(List) wr.getResponseData();
                
                for(Object allUsers:usersList){
                    
                     HashMap<String,Object> user = (HashMap<String, Object>) allUsers;
                       
                List allAttendance = (List) user.get("userAttendance");


        %>
        <h5 align="center">User Name <%=user.get("firstName")+" "+user.get("lastName") %></h5>
        <table class="table"  style="width: 45%;margin-left: auto;margin-right: auto">
            <thead class="thead-dark">
            </thead>
            <thead class="thead-dark">
                <tr>      
                    <th scope="col">Attendance Status</th>
                    <th scope="col">Attendance Date</th>

                </tr>
            </thead>
            <tbody>
                <%                    for (Object attendances : allAttendance) {
                        HashMap<String, String> attend = (HashMap<String, String>) attendances;

                %>
                <tr>
                    <td><%=attend.get("status")%></td>
                    <td><%=attend.get("attendanceDate")%></td>
                </tr>
                <%  } %>

                   
            </tbody>
        </table>
       <%  }  }%>
        
    </body>
</html>
