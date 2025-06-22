<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Complaint" %>
<%@ page import="com.example.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"EMPLOYEE".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    Complaint editComplaint = (Complaint) request.getAttribute("editComplaint");
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    String formAction = (editComplaint != null) ? "editComplaint" : "submitComplaint";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Employee Dashboard</title>
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
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --gradient-success: linear-gradient(135deg, #10b981, #059669);
            --gradient-warning: linear-gradient(135deg, #f59e0b, #d97706);
            --gradient-danger: linear-gradient(135deg, #ef4444, #dc2626);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: var(--gradient-primary);
            min-height: 100vh;
            color: var(--text-primary);
            padding: 2rem 1rem;
        }

        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            background: var(--card-background);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--border-color);
            backdrop-filter: blur(10px);
        }

        .header-section {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow);
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
            background: var(--gradient-primary);
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
            white-space: nowrap;
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, #4b5563, #374151);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .form-card {
            background: var(--card-background);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }

        .form-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
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
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.1rem;
        }

        .form-floating {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .form-floating > .form-control {
            height: 3.5rem;
            padding: 1rem 0.75rem 0.25rem 0.75rem;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .form-floating > .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
            outline: none;
            background: white;
        }

        .form-floating > textarea.form-control {
            height: 120px;
            padding-top: 1.5rem;
            resize: vertical;
        }

        .form-floating > label {
            position: absolute;
            top: 0;
            left: 0;
            height: 100%;
            padding: 1rem 0.75rem;
            pointer-events: none;
            border: 1px solid transparent;
            transform-origin: 0 0;
            transition: opacity 0.1s ease-in-out, transform 0.1s ease-in-out;
            color: var(--text-secondary);
            font-weight: 500;
        }

        .btn-primary-custom {
            background: var(--gradient-primary);
            color: white;
            border: none;
            padding: 0.875rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary-custom:hover {
            background: linear-gradient(135deg, #1d4ed8, #1e40af);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary-custom {
            background: linear-gradient(135deg, #f1f5f9, #e2e8f0);
            color: var(--text-primary);
            border: 2px solid var(--border-color);
            padding: 0.875rem 2rem;
            border-radius: 12px;
            font-weight: 500;
            font-size: 1rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-secondary-custom:hover {
            background: linear-gradient(135deg, #e2e8f0, #cbd5e1);
            color: var(--text-primary);
            border-color: #cbd5e1;
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }

        .btn-group-custom {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
            flex-wrap: wrap;
        }

        .complaints-card {
            background: var(--card-background);
            border-radius: 16px;
            padding: 2rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }

        .complaints-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
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
            background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
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
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        .status-pending {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            color: #92400e;
            border: 1px solid #f59e0b;
        }

        .status-inprogress {
            background: linear-gradient(135deg, #dbeafe, #bfdbfe);
            color: #1e40af;
            border: 1px solid #2563eb;
        }

        .status-resolved {
            background: linear-gradient(135deg, #d1fae5, #a7f3d0);
            color: #065f46;
            border: 1px solid #10b981;
        }

        .table-actions {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .btn-edit {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            color: #92400e;
            border: 2px solid #f59e0b;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.85rem;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-edit:hover {
            background: var(--gradient-warning);
            color: white;
            border-color: #d97706;
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }

        .btn-delete {
            background: linear-gradient(135deg, #fee2e2, #fecaca);
            color: var(--danger-color);
            border: 2px solid #fecaca;
            padding: 0.5rem 1rem;
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
            background: var(--gradient-danger);
            color: white;
            border-color: var(--danger-color);
            transform: translateY(-2px);
            box-shadow: var(--shadow);
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

        .date-time {
            font-size: 0.9rem;
            color: var(--text-secondary);
            font-weight: 500;
        }

        /* Status icons */
        .status-pending::before { content: '⏳'; margin-right: 0.25rem; }
        .status-inprogress::before { content: '⚡'; margin-right: 0.25rem; }
        .status-resolved::before { content: '✅'; margin-right: 0.25rem; }

        /* Form validation styles */
        .form-control:invalid {
            border-color: var(--danger-color);
        }

        .form-control:valid {
            border-color: var(--success-color);
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
            body {
                padding: 1rem;
            }

            .main-container {
                padding: 1.5rem;
            }

            .form-card, .complaints-card {
                padding: 1.5rem;
            }

            .btn-group-custom {
                flex-direction: column;
            }

            .btn-primary-custom, .btn-secondary-custom {
                width: 100%;
                justify-content: center;
            }

            .table-responsive {
                font-size: 0.8rem;
            }

            .table td, .table th {
                padding: 0.5rem;
            }

            .table-actions {
                flex-direction: column;
            }

            .complaint-title, .complaint-description {
                max-width: 150px;
            }
        }

        @media (max-width: 575px) {
            .form-floating > .form-control {
                height: auto;
                padding: 1rem 0.75rem 0 0.75rem;
            }

            .welcome-text {
                font-size: 1.5rem;
            }

            .section-title {
                font-size: 1.25rem;
            }
        }
    </style>
</head>
<body>

<div class="main-container">
    <div class="header-section">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <h1 class="welcome-text">
                <div class="welcome-icon">
                    <i class="bi bi-person-badge"></i>
                </div>
                Welcome, <%= user.getUsername() %>!
            </h1>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                <i class="bi bi-box-arrow-right me-2"></i>
                Logout
            </a>
        </div>
    </div>

    <div class="form-card">
        <h2 class="section-title">
            <div class="section-icon">
                <i class="bi bi-<%= editComplaint != null ? "pencil-square" : "plus-circle" %>"></i>
            </div>
            <%= editComplaint != null ? "Edit Complaint" : "Submit New Complaint" %>
        </h2>

        <form action="${pageContext.request.contextPath}/<%= formAction %>" method="post" novalidate>
            <% if (editComplaint != null) { %>
            <input type="hidden" name="id" value="<%= editComplaint.getId() %>" />
            <% } %>

            <div style="max-width: 600px;">
                <div class="form-floating">
                    <input type="text" class="form-control" id="title" name="title" placeholder="Complaint Title" required
                           value="<%= editComplaint != null ? editComplaint.getTitle() : "" %>"/>
                    <label for="title">
                        <i class="bi bi-card-text me-2"></i>
                        Complaint Title
                    </label>
                </div>

                <div class="form-floating">
                    <textarea class="form-control" id="description" name="description" placeholder="Complaint Description" required><%= editComplaint != null ? editComplaint.getDescription() : "" %></textarea>
                    <label for="description">
                        <i class="bi bi-chat-text me-2"></i>
                        Description
                    </label>
                </div>
            </div>

            <div class="btn-group-custom">
                <button type="submit" class="btn-primary-custom">
                    <i class="bi bi-<%= editComplaint != null ? "arrow-clockwise" : "send" %>"></i>
                    <%= editComplaint != null ? "Update" : "Submit" %> Complaint
                </button>
                <% if (editComplaint != null) { %>
                <a href="${pageContext.request.contextPath}/viewMyComplaints" class="btn-secondary-custom">
                    <i class="bi bi-x-circle"></i>
                    Cancel
                </a>
                <% } %>
            </div>
        </form>
    </div>

    <div class="complaints-card">
        <h2 class="section-title">
            <div class="section-icon">
                <i class="bi bi-clipboard-data"></i>
            </div>
            My Complaints
        </h2>

        <div class="table-container">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                    <tr>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Remarks</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th style="min-width: 150px;">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if (complaints != null && !complaints.isEmpty()) {
                            for (Complaint c : complaints) {
                                String statusClass = "";
                                if ("PENDING".equalsIgnoreCase(c.getStatus())) statusClass = "status-pending";
                                else if ("IN_PROGRESS".equalsIgnoreCase(c.getStatus())) statusClass = "status-inprogress";
                                else if ("RESOLVED".equalsIgnoreCase(c.getStatus())) statusClass = "status-resolved";
                    %>
                    <tr>
                        <td><span class="complaint-title" title="<%= c.getTitle() %>"><%= c.getTitle() %></span></td>
                        <td><span class="complaint-description" title="<%= c.getDescription() %>"><%= c.getDescription() %></span></td>
                        <td><span class="status-badge <%= statusClass %>"><%= c.getStatus().replace('_', ' ') %></span></td>
                        <td><%= c.getRemarks() != null && !c.getRemarks().isEmpty() ? c.getRemarks() : "-" %></td>
                        <td><span class="date-time"><%= c.getDate() %></span></td>
                        <td><span class="date-time"><%= c.getTime() %></span></td>
                        <td class="table-actions">
                            <% if (!"RESOLVED".equalsIgnoreCase(c.getStatus())) { %>
                            <a href="editComplaint?id=<%= c.getId() %>" class="btn-edit" title="Edit Complaint">
                                <i class="bi bi-pencil"></i>
                                Edit
                            </a>
                            <a href="deleteComplaint?id=<%= c.getId() %>" class="btn-delete"
                               onclick="return confirm('Are you sure you want to delete this complaint?')" title="Delete Complaint">
                                <i class="bi bi-trash"></i>
                                Delete
                            </a>
                            <% } else { %>
                            <span class="text-muted">
                                <i class="bi bi-lock"></i>
                                Resolved
                            </span>
                            <% } %>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="7" class="no-complaints">
                            <div class="no-complaints-icon">
                                <i class="bi bi-inbox"></i>
                            </div>
                            <div>
                                <h5>No complaints found</h5>
                                <p class="mb-0">You haven't submitted any complaints yet.</p>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Form validation enhancement
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('form');
        const titleInput = document.getElementById('title');
        const descriptionInput = document.getElementById('description');

        // Real-time validation
        function validateField(field) {
            if (field.value.trim() === '') {
                field.classList.add('is-invalid');
                field.classList.remove('is-valid');
            } else {
                field.classList.add('is-valid');
                field.classList.remove('is-invalid');
            }
        }

        titleInput.addEventListener('input', () => validateField(titleInput));
        descriptionInput.addEventListener('input', () => validateField(descriptionInput));

        // Form submission validation
        form.addEventListener('submit', function(e) {
            let isValid = true;

            if (titleInput.value.trim() === '') {
                titleInput.classList.add('is-invalid');
                isValid = false;
            }

            if (descriptionInput.value.trim() === '') {
                descriptionInput.classList.add('is-invalid');
                isValid = false;
            }

            if (!isValid) {
                e.preventDefault();
                // Scroll to first invalid field
                const firstInvalid = form.querySelector('.is-invalid');
                if (firstInvalid) {
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    firstInvalid.focus();
                }
            }
        });

        // Smooth animations for status badges
        const statusBadges = document.querySelectorAll('.status-badge');
        statusBadges.forEach(badge => {
            badge.style.transform = 'scale(1)';
            badge.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.05)';
            });
            badge.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1)';
            });
        });
    });
</script>

</body>
</html>