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
import java.util.List;

@WebServlet("/viewMyComplaints")
public class ViewMyComplaintsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("jsp/login.jsp");
            return;
        }

        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("ds");

        ComplaintDAO complaintDAO = new ComplaintDAO(ds);

        User user = (User) session.getAttribute("user");
        List<Complaint> complaintList = complaintDAO.getComplaintsByUserId(user.getId());

        req.setAttribute("complaints", complaintList);
        req.getRequestDispatcher("jsp/employee_dashboard.jsp").forward(req, resp);
    }
}
