<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Issues</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #a445b2, #fa4299);
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .container {
            background: white;
            width: 90%;
            max-width: 800px;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
            color: #a445b2;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .table-container {
    max-height: 400px; /* Adjust height as needed */
    overflow-y: auto;
    overflow-x: auto;
    width: 100%;
}


        th, td {
            border: 1px solid #a445b2;
            padding: 10px;
            text-align: center;
            color: black;
            white-space: nowrap;
        }

        th {
            background: #a445b2;
            color: white;
        }

        .btn {
            background: #a445b2;
            color: white;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
            transition: 0.3s ease-in-out;
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

        /* Raise Issue Form */
        .form-container {
            display: none;
            background: #fce4ec;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin-top: 20px;
        }

        select, input, textarea {
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 2px solid #a445b2;
            width: 100%;
            color: #a445b2;
            margin: 10px 0;
        }

        select:focus, input:focus, textarea:focus {
            border-color: #fa4299;
            outline: none;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Issues Management System</h1>
        
        <button class="btn" onclick="goBack()">Back to Home</button>

        <!-- Raise Issue Button -->
        <button th;if="${user.role=='USER'}" class="btn" id="raiseIssueBtn" onclick="showIssueForm()">Raise Issue</button>

        <!-- Raise Issue Form -->
        <div class="form-container" id="issueForm">
            <h3 style="color: #a445b2;">Raise an Issue</h3>
            <form action="/raiseIssue" method="post" enctype="multipart/form-data" th:object="${issue}">
                
				<select id="typeDropdownSearch" name="type" onchange="updateSubTypes(); toggleNewTypeInput()" required>
    <option disabled selected>Select Type</option>
    <th:block th:each="i : ${types}">
        <option th:value="${i}" th:text="${i}"></option>
    </th:block>
    <option value="newType">Other</option>
</select>

<div class="form-group">
    <input type="text" id="newTypeInput" name="otherType" placeholder="Enter New Type" style="display: none;">
</div>

<select id="subTypeDropdownSearch"  disabled onchange="toggleNewSubTypeInput()" name="subType" required>
    <option disabled selected>Select Sub-Type</option>
    <th:block th:each="incident : ${dis}">
        <option th:value="${incident.subType}" th:text="${incident.subType}" th:data-type="${incident.type}" th:data-solution="${incident.solution}"></option>
    </th:block>
    <option value="newSubType">Other</option>
</select>

<div class="form-group">
    <input type="text" id="newSubTypeInput" name="otherSubType" placeholder="Enter New Sub-Type" style="display: none;">
</div>

<textarea rows="4" name="discription" placeholder="Enter Description" required></textarea>
<input type="file" name="image" aria-describedby="inputGroupFileAddon04" aria-label="Upload">

                <button class="btn" type="submit">Submit</button>
                <button type="button" class="btn" onclick="closeIssueForm()">Cancel</button>
            </form>
        </div>

        <!-- Issues Table -->
       <div class="table-container">
    <table>
        <thead>
            <tr>
                <th>S.no</th>
                <th>Type</th>
                <th>Sub-Type</th>
                <th>Description</th>
                <th>Name</th>
                <th>Mobile Number</th>
                <th>Attachment</th>
                <th th:if="${user.role=='USER'}">Clear</th>
            </tr>
        </thead>
        <tbody>
            <tr th:each="i, status : ${issues}">
                <td th:text="${status.index + 1}"></td>
                <td th:text="${i.type}"></td>
                <td th:text="${i.subType}"></td>
                <td th:text="${i.discription}"></td>
                <td th:text="${names[status.index]}"></td>
                <td th:text="${i.username}"></td>
                <td><img height="250px" th:src="@{'/image/' + ${i.id}}" alt="Image not found"></td>     
                <td th:if="${user.role=='USER'}">
                    <form th:action="@{'/clear/' + ${i.id}}">
                        <input type="submit" class="btn" value="CLEARED">
                    </form>
                </td>
            </tr>
        </tbody>
    </table>
</div>

        
    </div>

    <script>
        function showIssueForm() {
            document.getElementById("raiseIssueBtn").style.display = "none";
            document.getElementById("issueForm").style.display = "block";
        }

        function closeIssueForm() {
            document.getElementById("issueForm").style.display = "none";
            document.getElementById("raiseIssueBtn").style.display = "inline-block";
        }

        function goBack() {
            window.location.href = "/home";
        }
        
        function updateSubTypes() {
            var typeDropdown = document.getElementById("typeDropdownSearch");
            var subTypeDropdown = document.getElementById("subTypeDropdownSearch");

            var selectedType = typeDropdown.value;

            if (selectedType) {
                subTypeDropdown.disabled = false;

                var options = subTypeDropdown.getElementsByTagName("option");
                for (var i = 0; i < options.length-1; i++) {
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
        }
        function toggleNewTypeInput() {
            var dropdown = document.getElementById("typeDropdownSearch");
            var newTypeInput = document.getElementById("newTypeInput");
            var newSubTypeInput = document.getElementById("newSubTypeInput");
            var subTypeDropdown = document.getElementById("subTypeDropdownSearch");

            if (dropdown.value === "newType") {
                newTypeInput.style.display = "block";
                newTypeInput.value = "";
                newSubTypeInput.style.display = "block";
                newSubTypeInput.value = "";
                subTypeDropdown.disabled = true;
                subTypeDropdown.value = "newSubType";
            } else {
                newTypeInput.style.display = "none";
                newTypeInput.value = "";
                newSubTypeInput.style.display = "none";
                newSubTypeInput.value = "";
                subTypeDropdown.disabled = false;
                subTypeDropdown.value = "";
            }
        }

        function toggleNewSubTypeInput() {
            var dropdown = document.getElementById("subTypeDropdownSearch");
            var newSubTypeInput = document.getElementById("newSubTypeInput");

            if (dropdown.value === "newSubType") {
                newSubTypeInput.style.display = "block";
                newSubTypeInput.value = "";
            } else {
                newSubTypeInput.style.display = "none";
                newSubTypeInput.value = "";
            }
        }


    </script>

</body>
</html>
