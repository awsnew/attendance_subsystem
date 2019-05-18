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
        <title>Attendance Management UI (Sub-System)</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <h1 align="center">Welcome to Attendance Management</h1>
        <h3 align="left" style="margin-left: 20px"><a href="report.jsp" class="btn btn-primary">Attendance Report</a></h3>
        <br/>
        <%  
         String msg=request.getParameter("msg");
         if(msg!=null && !msg.isEmpty()){
     %>
     
     <div class="alert alert-success">
  <strong>Success!</strong> <%=msg%>
</div>
     <%
          }  
            %>

        <h3 align="center">Register User</h3>
        <form class="" action="register" method="post">
            <div style="width: 65%;margin-left: auto;margin-right: auto;margin-bottom: 35px">
                <div class="form-group">
                    <label for="uid">User ID:</label>
                    <input type="text" name="uid" class="form-control" id="uid">
                </div>
                <div class="form-group">
                    <label for="fnm">First Name:</label>
                    <input type="text" class="form-control" name="fnm" id="fnm">
                </div>
                <div class="form-group">
                    <label for="lnm">Last Name:</label>
                    <input class="form-control" type="text" name="lnm" id="lnm">

                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </div>
        </form>
        
        <%
            HttpResponse<WebReponse> allUserResponse = Unirest.get("http://localhost:8080/ams/api/attendance/getAllUser")
                    .header("accept", "application/json")
                    .header("Content-Type", "application/json")
                    .asObject(WebReponse.class);
            
             List  allUsers=(List)allUserResponse.getBody().getResponseData();
             
            
        %>

        <table class="table"  style="width: 65%;margin-left: auto;margin-right: auto">
            <thead class="thead-dark">
            </thead>
            <thead class="thead-dark">
                <tr>
                    <th scope="col">User ID</th>
                    <th scope="col">First Name</th>
                    <th scope="col">Last Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%    
                   for (Object users : allUsers) {
                      HashMap<String,String> user=(HashMap<String,String>)users;   
                   
                    %>
                <tr>
                    <td><%=user.get("userId")%></td>
                    <td><%=user.get("firstName")%></td>
                    <td><%=user.get("lastName")%></td>
                    <td><a href="attendance.jsp?uid=<%=user.get("userId")%>" target="">View Attendance</a></td>
                </tr>
              <%  }%>
            </tbody>
        </table>



        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    </body>
</html>
