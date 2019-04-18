package com.subsystem.servlet;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.ObjectMapper;
import com.mashape.unirest.http.Unirest;
import com.subsystem.request.User;
import com.subsystem.request.UserAttendance;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.WebApplicationException;


@WebServlet(name = "MarkAttendanceServlet", urlPatterns = {"/markAttendance"},loadOnStartup = 1)
public class MarkAttendanceServlet extends HttpServlet {

    private static  String middlewareURL="http://localhost:8080/ams/api/attendance/";
    
    @Override
    public void init()throws ServletException{
         // Initialize Unirest Object mapper to map JSON to java object
        Unirest.setObjectMapper(new ObjectMapper() {
            private com.fasterxml.jackson.databind.ObjectMapper jacksonObjectMapper
                    = new com.fasterxml.jackson.databind.ObjectMapper();

            public <T> T readValue(String value, Class<T> valueType) {
                try {
                    return jacksonObjectMapper.readValue(value, valueType);
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }

            public String writeValue(Object value) {
                try {
                    return jacksonObjectMapper.writeValueAsString(value);
                } catch (JsonProcessingException e) {
                    throw new RuntimeException(e);
                }
            }
        });
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try{
            
            UserAttendance uat=new UserAttendance();
            uat.setUserId(request.getParameter("uid"));
            uat.setStatus(request.getParameter("status"));
            SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
            uat.setAttendanceDate(sdf.format(new Date()));
            
            // Call the middlware for request submission
            HttpResponse<WebReponse> userRegisterResponse = Unirest.post(middlewareURL+"markAttendance")
                    .header("accept", "application/json")
                    .header("Content-Type", "application/json")
                    .body(uat)
                    .asObject(WebReponse.class);
            
           response.sendRedirect("attendance.jsp?uid="+request.getParameter("uid")+"&msg="+userRegisterResponse.getBody().getMessage());
        }catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("attendance.jsp?uid="+request.getParameter("uid")+"&msg=Internal Server error");
        }
    }

   

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "User registration servlet";
    }

}
