package com.example.controller;

import com.example.dao.ComplaintDAO;
import com.example.model.Complaint;
import com.example.model.User;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;

@WebServlet("/deleteComplaint")
public class DeleteComplaintServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("ds");

        ComplaintDAO complaintDAO = new ComplaintDAO(ds);

        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        int id = Integer.parseInt(req.getParameter("id"));
        Complaint complaint = complaintDAO.getComplaintById(id);

        if (!"RESOLVED".equals(complaint.getStatus())) {
            complaintDAO.deleteComplaint(id);
        }

        if (user.getRole().equals("ADMIN")) {
            resp.sendRedirect("admin/complaints");
        } else {
            resp.sendRedirect("viewMyComplaints");
        }
    }
}
