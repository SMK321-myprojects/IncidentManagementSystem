<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Default Incidents</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #a445b2, #fa4299);
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background: white;
            width: 90%;
            max-width: 700px;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
        }

        h1 {
            color: #a445b2;
            font-size: 24px;
            margin-bottom: 20px;
        }

        .btn {
            background: #a445b2;
            color: white;
            padding: 12px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
            transition: 0.3s ease-in-out;
            display: inline-block;
            margin: 10px 5px;
        }

        .btn:hover {
            background: #fa4299;
            transform: scale(1.05);
        }

        .btn:disabled {
            background: #ccc;
            cursor: not-allowed;
        }

        .dropdown-container, .form-group {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 15px 0;
        }

        select, input, textarea {
            padding: 12px;
            font-size: 16px;
            border-radius: 5px;
            border: 2px solid #a445b2;
            width: 100%;
            color: #a445b2;
        }

        select:focus, input:focus, textarea:focus {
            border-color: #fa4299;
            outline: none;
        }

        .form-container {
            display: none;
            background: #fce4ec;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        #solutionContainer {
            margin-top: 20px;
            padding: 15px;
            background: #fce4ec;
            border-radius: 10px;
            color: #a445b2;
            font-size: 18px;
            font-weight: bold;
            display: none;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Default Incidents Management</h1>

        <!-- Add Default Incident Button -->
        <button th:if="${user.role=='ADMIN'}" class="btn" id="addIncidentBtn" onclick="showForm()">Add Default Incident</button>
<button class="btn" onclick="goBack()">Back to Home</button>


        <!-- Add Default Incident Form -->
        <div class="form-container" id="incidentForm">
            <h3 style="color: #a445b2;">Add Default Incident</h3>

            <form action="/addDi" method="post" th:object="${di}">
                <div class="form-group">
                    <select id="typeDropdown" name="type" onchange="toggleNewTypeInput()">
                        <option value="" disabled selected>Select Type</option>
                        <th:block th:each="i : ${types}">
                            <option th:value="${i}" th:text="${i}"></option>
                        </th:block>
                        <option value="newType">New Type</option>
                    </select>
                </div>

                <div class="form-group">
                    <input type="text" id="newTypeInput" name="otherType" placeholder="Enter New Type" style="display: none;">
                </div>

                <input type="text" name="subType" placeholder="Sub Type" required>
                <textarea rows="4" name="solution" placeholder="Enter Solution"></textarea>

                <button class="btn" type="submit">Submit</button>
                <button type="button" class="btn" onclick="closeForm()">Cancel</button>
            </form>
        </div>

        <!-- Search Incident -->
        <form>
            <div class="dropdown-container">
                <select id="typeDropdownSearch" onchange="updateSubTypes()" required>
                    <option value="">Select Type</option>
                    <th:block th:each="i : ${types}">
                        <option th:value="${i}" th:text="${i}"></option>
                    </th:block>
                </select>

                <select id="subTypeDropdownSearch" disabled onchange="validateSearchButton()">
                    <option value="">Select Sub-Type</option>
                    <th:block th:each="incident : ${dis}">
                        <option th:value="${incident.subType}" th:text="${incident.subType}" th:data-type="${incident.type}" th:data-solution="${incident.solution}"></option>
                    </th:block>
                </select>
            </div>

            <button type="button" class="btn" id="searchBtn" onclick="searchIncident()" disabled>Search Incident</button>
        </form>

        <!-- Solution Display -->
        <div id="solutionContainer"></div>
    </div>

    <script>
        function showForm() {
            document.getElementById("addIncidentBtn").style.display = "none";
            document.getElementById("incidentForm").style.display = "block";
        }

        function closeForm() {
            document.getElementById("incidentForm").style.display = "none";
            document.getElementById("addIncidentBtn").style.display = "inline-block";
        }

        function toggleNewTypeInput() {
            var dropdown = document.getElementById("typeDropdown");
            var newTypeInput = document.getElementById("newTypeInput");

            if (dropdown.value === "newType") {
                newTypeInput.style.display = "block";
                newTypeInput.value = "";
            } else {
                newTypeInput.style.display = "none";
                newTypeInput.value = "";
            }
        }

        function updateSubTypes() {
            var typeDropdown = document.getElementById("typeDropdownSearch");
            var subTypeDropdown = document.getElementById("subTypeDropdownSearch");

            var selectedType = typeDropdown.value;

            if (selectedType) {
                subTypeDropdown.disabled = false;

                var options = subTypeDropdown.getElementsByTagName("option");
                for (var i = 0; i < options.length; i++) {
                    var typeAttribute = options[i].getAttribute("data-type");
                    if (typeAttribute === selectedType || options[i].value === "") {
                        options[i].style.display = "block";
                    } else {
                        options[i].style.display = "none";
                    }
                }

                subTypeDropdown.value = "";
            } else {
                subTypeDropdown.disabled = true;
                subTypeDropdown.value = "";
            }

            validateSearchButton();
        }

        function validateSearchButton() {
            var typeDropdown = document.getElementById("typeDropdownSearch");
            var subTypeDropdown = document.getElementById("subTypeDropdownSearch");
            var searchBtn = document.getElementById("searchBtn");

            if (typeDropdown.value && subTypeDropdown.value) {
                searchBtn.disabled = false;
            } else {
                searchBtn.disabled = true;
            }
        }

        function searchIncident() {
            var subTypeDropdown = document.getElementById("subTypeDropdownSearch");
            var solutionContainer = document.getElementById("solutionContainer");

            var selectedOption = subTypeDropdown.options[subTypeDropdown.selectedIndex];
            var solution = selectedOption.getAttribute("data-solution");

            if (solution) {
                solutionContainer.innerHTML = "<strong>Solution:</strong> " + solution;
                solutionContainer.style.display = "block";
            } else {
                solutionContainer.style.display = "none";
            }
        }
        function goBack() {
            window.location.href = "/home";
        }
    </script>

</body>
</html>
