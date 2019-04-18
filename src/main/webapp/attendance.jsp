
<%@page import="com.subsystem.request.User"%>
<%@page import="java.util.HashMap"%>
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
        <title>User Attendance Details</title>
    </head>
    <body>
        
        <br/>
        <%
            String msg = request.getParameter("msg");
            if (msg != null && !msg.isEmpty()) {
        %>

        
            <%
                if (msg.contains("Internal")) {
            %>
            <div class="alert alert-success">
            <strong>Error!</strong> <%=msg%>
            </div>
            <%} else {
            %>
            <div class="alert alert-success">
            <strong>Success!</strong> <%=msg%>
             </div>
            <%}%>
       
        <%
            }
        %>

        <h3 align="center">Mark User Attendance</h3>
        <form class="" action="markAttendance" method="post">
            <div style="width: 65%;margin-left: auto;margin-right: auto;margin-bottom: 35px">
                <div class="form-group">
                    <label for="status">Attendance Status: </label>
                    <select  name="status" class="form-control" id="status">
                        <option value="PRESENT">PRESENT</option>
                        <option value="ABSENT">ABSENT</option>
                    </select>
                </div>
                <input type="hidden" name="uid" value='<%=request.getParameter("uid")%>' />
                <button type="submit" class="btn btn-primary">Submit</button>
            </div>
            <br/>
        </form>


        <%
            HttpResponse<WebReponse> userAttendanceResponse = Unirest.get("http://localhost:8080/ams/api/attendance/getUserAttendance/" + request.getParameter("uid"))
                    .header("accept", "application/json")
                    .header("Content-Type", "application/json")
                    .asObject(WebReponse.class);
              WebReponse wr=userAttendanceResponse.getBody();
              System.out.println("----- " + wr.getResponseData());
            if(wr.getResponseData() instanceof HashMap){
            HashMap mwResponse = (HashMap) userAttendanceResponse.getBody().getResponseData();
            
            List allUsers = (List) mwResponse.get("userAttendance");


        %>

        <h3 align="center">User Attendance Details</h3>
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
                <%                    for (Object users : allUsers) {
                        HashMap<String, String> user = (HashMap<String, String>) users;

                %>
                <tr>
                    <td><%=user.get("status")%></td>
                    <td><%=user.get("attendanceDate")%></td>
                </tr>
                <%  }}%>
            </tbody>
        </table>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    </body>
</html>
