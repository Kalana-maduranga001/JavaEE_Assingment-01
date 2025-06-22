package com.example.controller;

import com.example.dao.ComplaintDAO;
import com.example.model.Complaint;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;

@WebServlet("/editComplaint")
public class EditComplaintServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("ds");

        ComplaintDAO complaintDAO = new ComplaintDAO(ds);

        int id = Integer.parseInt(req.getParameter("id"));
        Complaint complaint = complaintDAO.getComplaintById(id);

        if (!"RESOLVED".equals(complaint.getStatus())) {
            req.setAttribute("editComplaint", complaint);
            req.setAttribute("complaints", complaintDAO.getComplaintsByUserId(complaint.getUserId()));
            req.getRequestDispatcher("jsp/employee_dashboard.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("viewMyComplaints");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("ds");

        ComplaintDAO complaintDAO = new ComplaintDAO(ds);

        int id = Integer.parseInt(req.getParameter("id"));
        String title = req.getParameter("title");
        String description = req.getParameter("description");

        Complaint complaint = new Complaint();
        complaint.setId(id);
        complaint.setTitle(title);
        complaint.setDescription(description);

        complaintDAO.updateComplaint(complaint);
        resp.sendRedirect("viewMyComplaints");
    }
}
