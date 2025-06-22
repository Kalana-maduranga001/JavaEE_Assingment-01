<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Complaint" %>
<%@ page import="com.example.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        :root {
            --primary-color: #2563eb;
            --primary-hover: #1d4ed8;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --background-color: #f8fafc;
            --card-background: #ffffff;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --border-color: #e2e8f0;
            --shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: var(--text-primary);
        }

        .main-container {
            background: var(--background-color);
            min-height: 100vh;
            padding: 2rem 0;
        }

        .header-section {
            background: var(--card-background);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--border-color);
        }

        .welcome-text {
            font-size: 1.75rem;
            font-weight: 600;
            color: var(--text-primary);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .welcome-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }

        .logout-btn {
            background: linear-gradient(135deg, #6b7280, #4b5563);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: var(--shadow);
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, #4b5563, #374151);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .complaints-card {
            background: var(--card-background);
            border-radius: 16px;
            padding: 2rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--border-color);
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-icon {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.1rem;
        }

        .table-container {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--shadow);
            border: 1px solid var(--border-color);
        }

        .table-responsive {
            max-height: 500px;
            overflow-y: auto;
        }

        .table {
            margin: 0;
            font-size: 0.9rem;
        }

        .table thead th {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            color: var(--text-primary);
            font-weight: 600;
            border: none;
            padding: 1rem 0.75rem;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .table tbody tr {
            transition: all 0.2s ease;
            border-bottom: 1px solid var(--border-color);
        }

        .table tbody tr:hover {
            background-color: #f8fafc;
            transform: translateY(-1px);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .table td {
            padding: 1rem 0.75rem;
            vertical-align: middle;
            border: none;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border: none;
            min-width: 130px;
        }

        .status-badge option {
            padding: 0.5rem;
        }

        .status-pending {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            color: #92400e;
        }

        .status-in-progress {
            background: linear-gradient(135deg, #dbeafe, #bfdbfe);
            color: #1e40af;
        }

        .status-resolved {
            background: linear-gradient(135deg, #d1fae5, #a7f3d0);
            color: #065f46;
        }

        .form-control-sm {
            border-radius: 8px;
            border: 2px solid var(--border-color);
            padding: 0.5rem 0.75rem;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            min-width: 150px;
        }

        .form-control-sm:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            outline: none;
        }

        .btn-update {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow);
        }

        .btn-update:hover {
            background: linear-gradient(135deg, var(--primary-hover), #1e40af);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-delete {
            background: linear-gradient(135deg, #fee2e2, #fecaca);
            color: var(--danger-color);
            border: 2px solid #fecaca;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.85rem;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-delete:hover {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
            color: white;
            border-color: var(--danger-color);
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .no-complaints {
            text-align: center;
            padding: 3rem;
            color: var(--text-secondary);
        }

        .no-complaints-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .complaint-id {
            font-weight: 600;
            color: var(--primary-color);
        }

        .complaint-title {
            font-weight: 500;
            color: var(--text-primary);
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .complaint-description {
            max-width: 250px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: var(--text-secondary);
        }

        .user-id {
            background: linear-gradient(135deg, #f3f4f6, #e5e7eb);
            color: var(--text-primary);
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-weight: 500;
            font-size: 0.85rem;
        }

        /* Scrollbar styling */
        .table-responsive::-webkit-scrollbar {
            width: 8px;
        }

        .table-responsive::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 4px;
        }

        .table-responsive::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #cbd5e1, #94a3b8);
            border-radius: 4px;
        }

        .table-responsive::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #94a3b8, #64748b);
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .main-container {
                padding: 1rem;
            }

            .header-section, .complaints-card {
                padding: 1.5rem;
            }

            .table-responsive {
                font-size: 0.8rem;
            }

            .table td, .table th {
                padding: 0.5rem;
            }
        }
    </style>
</head>
<body>

<div class="main-container">
    <div class="container">
        <div class="header-section">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <h1 class="welcome-text">
                    <div class="welcome-icon">
                        <i class="bi bi-person-gear"></i>
                    </div>
                    Welcome Admin: <%= user.getUsername() %>!
                </h1>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                    <i class="bi bi-box-arrow-right me-2"></i>
                    Logout
                </a>
            </div>
        </div>

        <div class="complaints-card">
            <h2 class="section-title">
                <div class="section-icon">
                    <i class="bi bi-clipboard-data"></i>
                </div>
                All Complaints
            </h2>

            <div class="table-container">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>User ID</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Remarks</th>
                            <th style="min-width: 120px;">Update</th>
                            <th style="min-width: 120px;">Delete</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            if (complaints != null && !complaints.isEmpty()) {
                                for (Complaint c : complaints) {
                        %>
                        <tr>
                            <form action="${pageContext.request.contextPath}/admin/updateComplaint" method="post" class="d-flex gap-2 align-items-center">
                                <td><span class="complaint-id">#<%= c.getId() %></span></td>
                                <td><span class="user-id"><%= c.getUserId() %></span></td>
                                <td><span class="complaint-title" title="<%= c.getTitle() %>"><%= c.getTitle() %></span></td>
                                <td><span class="complaint-description" title="<%= c.getDescription() %>"><%= c.getDescription() %></span></td>
                                <td style="min-width: 150px;">
                                    <select name="status" class="form-select form-select-sm status-badge" required>
                                        <option value="PENDING" <%= "PENDING".equals(c.getStatus()) ? "selected" : "" %>>PENDING</option>
                                        <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(c.getStatus()) ? "selected" : "" %>>IN_PROGRESS</option>
                                        <option value="RESOLVED" <%= "RESOLVED".equals(c.getStatus()) ? "selected" : "" %>>RESOLVED</option>
                                    </select>
                                </td>
                                <td>
                                    <input type="text" name="remarks" class="form-control form-control-sm"
                                           placeholder="Add remarks..."
                                           value="<%= c.getRemarks() == null ? "" : c.getRemarks() %>" />
                                </td>
                                <td>
                                    <input type="hidden" name="id" value="<%= c.getId() %>" />
                                    <button type="submit" class="btn btn-update">
                                        <i class="bi bi-arrow-clockwise me-1"></i>
                                        Update
                                    </button>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/deleteComplaint?id=<%= c.getId() %>"
                                       onclick="return confirm('Are you sure you want to delete this complaint?')"
                                       class="btn-delete">
                                        <i class="bi bi-trash"></i>
                                        Delete
                                    </a>
                                </td>
                            </form>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="8" class="no-complaints">
                                <div class="no-complaints-icon">
                                    <i class="bi bi-inbox"></i>
                                </div>
                                <div>
                                    <h5>No complaints found</h5>
                                    <p class="mb-0">There are currently no complaints to display.</p>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Add dynamic status coloring
    document.addEventListener('DOMContentLoaded', function() {
        const statusSelects = document.querySelectorAll('select[name="status"]');
        statusSelects.forEach(select => {
            updateStatusColor(select);
            select.addEventListener('change', function() {
                updateStatusColor(this);
            });
        });
    });

    function updateStatusColor(select) {
        const value = select.value;
        select.className = 'form-select form-select-sm status-badge';

        if (value === 'PENDING') {
            select.classList.add('status-pending');
        } else if (value === 'IN_PROGRESS') {
            select.classList.add('status-in-progress');
        } else if (value === 'RESOLVED') {
            select.classList.add('status-resolved');
        }
    }
</script>

</body>
</html>