# 🛠️ Complaint Management System - Jakarta EE Project

A simple web-based Complaint Management System built using **JSP**, **Servlets**, and **MySQL**, designed to allow employees to submit and manage complaints, while admins can review and resolve them.

---

## 📌 Project Objective

This project was developed as part of the **Advanced API Development** module. It demonstrates the use of Jakarta EE technologies to build a role-based web application that handles complaint tracking and resolution between employees and administrators.

---

## 🚀 Technologies Used

- **Java EE (Servlets & JSP)**
- **MySQL**
- **Apache DBCP (Database Connection Pool)**
- **Apache Tomcat**
- **JDBC**
- **HTML/CSS**

---

## 👤 User Roles & Functionalities

### 👨‍💼 Employee
- Login with credentials
- Submit new complaints
- View list of own complaints
- Edit unresolved complaints
- Delete unresolved complaints

### 🛡️ Admin
- Login with admin credentials
- View all complaints from all users
- Update complaint status (PENDING / IN_PROGRESS / RESOLVED)
- Add remarks to complaints
- Delete any complaint

---

## 🔧 System Architecture (MVC)

```
[Client]
   |
[JSP Pages]  ←→  [Servlets]  ←→  [DAO Layer]  ←→  [MySQL Database]
(View)         (Controller)     (Model/Data Access)
```

- **View (JSP)**: Displays forms and data
- **Controller (Servlets)**: Handles HTTP requests and session logic
- **Model (DAO + JavaBeans)**: Business objects and DB logic
- **DB Connection**: Managed via Apache DBCP and stored in ServletContext

---

## 💡 How Form Submissions Work

- Forms use `method="post"` and trigger specific Servlets:
    - `/submitComplaint`
    - `/editComplaint`
    - `/admin/updateComplaint`
- Servlets:
    - Read form data using `request.getParameter(...)`
    - Call DAO methods to interact with the database
    - Redirect or forward to the appropriate JSP

---

## 🗂️ Folder Structure

```
CMS_Project/
├── src/
│   └── com.example/
│       ├── controller/
│       ├── dao/
│       ├── model/
│       └── util/
├── web/
│   ├── jsp/
│   │   ├── login.jsp
│   │   ├── employee_dashboard.jsp
│   │   └── admin_dashboard.jsp
│   └── css/
├── db/
│   └── schema.sql
├── README.md
```

---

## ⚙️ How to Run

1. Import project into **IntelliJ IDEA** or **Eclipse** with Java EE support
2. Create the database using `db/schema.sql` in MySQL
3. Update DB credentials in `DBConnectionPool.java` if needed
4. Deploy the project to **Apache Tomcat**
5. Visit: `http://localhost:8080/cms_db/`

---

## 🎥 Video Demo

> [YouTube Link](https://youtu.be/Y9dOh-gRDz4)
