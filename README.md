# Incident Management System

An **Incident Management System (IMS)** built with **Java (Spring Boot)** to efficiently handle user-reported issues, manage incidents, and streamline communication between users and support teams. The system allows users to raise tickets, track their status, and enables administrators to resolve incidents while maintaining a record for future improvements.

---

## 📌 Features

- **User Management**
  - User registration and login (secured with Spring Security).
  - Role-based access (User, Admin).

- **Incident Handling**
  - Users can create and track incidents.
  - Admins can view, update, and resolve incidents.

- **Issue Management**
  - Categorization and tracking of issues.
  - Default incident templates for faster reporting.

- **Authentication & Security**
  - Spring Security with user authentication and authorization.
  - Custom `UserDetailsService` implementation.

- **User Interface**
  - JSP-based templates (`home.jsp`, `issues.jsp`, `login.jsp`, etc.).
  - Simple and intuitive UI for end users.

---

## 🏗️ Project Structure

IncidentManagementSystem/
│── .classpath
│── .gitattributes
│── .gitignore
│── .project
│── HELPME.md
│── mvnw
│── mvnw.cmd
│── pom.xml
│── src/
│ ├── main/
│ │ ├── java/com/example/IncidentManagementSystem/
│ │ │ ├── controller/ # Controllers (e.g., AppController.java)
│ │ │ ├── entities/ # Entity classes (User, Issue, DefaultIncident)
│ │ │ ├── repositories/ # JPA Repositories
│ │ │ ├── security/ # Security configuration & services
│ │ │ ├── service/ # Business logic services
│ │ │ └── IncidentManagementSystemApplication.java
│ │ ├── resources/
│ │ │ ├── static/ # Static resources (CSS, JS, Images)
│ │ │ ├── templates/ # JSP views (home.jsp, login.jsp, issues.jsp, etc.)
│ │ │ └── application.properties
│ └── test/java/com/example/IncidentManagementSystem/
│ └── IncidentManagementSystemApplicationTests.java
│
└── target/
├── classes/ # Compiled class files
└── test-classes/ # Test class files

---

## ⚙️ Technologies Used

- **Backend:** Java, Spring Boot, Spring MVC, Spring Security  
- **Frontend:** JSP, HTML, CSS  
- **Database:** MySQL (via Spring Data JPA)  
- **Build Tool:** Maven  
- **Version Control:** Git  

---

## 🚀 Getting Started

### Prerequisites
Make sure you have the following installed:
- Java 17+  
- Maven 3.6+  
- MySQL Server  

### Installation & Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/IncidentManagementSystem.git
   cd IncidentManagementSystem
2. **Configure Database:-->**
spring.datasource.url=jdbc:mysql://localhost:3306/incidentdb
spring.datasource.username=yourusername
spring.datasource.password=yourpassword
spring.jpa.hibernate.ddl-auto=update

3. **Build the Project:-->**
mvn clean install

4. **Run the Application:-->**
mvn spring-boot:run

5. **Access in Browser:-->**
Open: http://localhost:8080

🧪 Testing
mvn test

📂 Key Files

1.IncidentManagementSystemApplication.java – Main entry point of the application.
2.AppController.java – Handles HTTP requests.
3.User.java, Issue.java, DefaultIncident.java – Entity models.
4.UserService.java, IssueService.java, UserIncidentService.java – Business logic.
5.SecurityConfig.java – Security configuration.
6.JSP templates inside src/main/resources/templates/.

## 📜 License  
This project is licensed under the **MIT License**. You are free to use, modify, and distribute it with attribution.  

## 🤝 Contribution  
Contributions are welcome!  
1. Fork the project  
2. Create a branch  
3. Submit a pull request  

## 👨‍💻 Author  
**Talasu Saimanikanta**  

- [LinkedIn](https://www.linkedin.com/in/talasu-saimanikanta-09bb2a260)  
- [GitHub]((https://github.com/SMK321-myprojects))  
