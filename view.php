<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "online_book_store_db";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $category_id = $_POST["category_id"];
    $new_name = $_POST["new_name"];

    // Update category name
    $sql = "UPDATE categories SET name='$new_name' WHERE id=$category_id";
    if ($conn->query($sql) === TRUE) {
        echo "Record updated successfully";
    } else {
        echo "Error updating record: " . $conn->error;
    }
}

// Fetch categories for the dropdown
$category_sql = "SELECT id, name FROM categories";
$category_result = $conn->query($category_sql);

// Fetch data from the view
$sql = "SELECT * FROM book_details";
$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Book Store</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
    </style>
</head>
<body>

<h2>Book Details</h2>

<table>
    <tr>
        <th>Book ID</th>
        <th>Title</th>
        <th>Author</th>
        <th>Category</th>
        <th>Description</th>
        <th>Cover</th>
        <th>File</th>
    </tr>
    <?php
    if ($result->num_rows > 0) {
        // Output data of each row
        while($row = $result->fetch_assoc()) {
            echo "<tr>
                <td>" . $row["book_id"] . "</td>
                <td>" . $row["title"] . "</td>
                <td>" . $row["author"] . "</td>
                <td>" . $row["category"] . "</td>
                <td>" . $row["description"] . "</td>
                <td><img src='" . $row["cover"] . "' width='50'></td>
                <td><a href='" . $row["file"] . "'>Download</a></td>
            </tr>";
        }
    } else {
        echo "<tr><td colspan='7'>No data found</td></tr>";
    }
    ?>
</table>

<h2>Update Category</h2>

<form method="post" action="">
    <label for="category_id">Select Category:</label>
    <select name="category_id" id="category_id" required>
        <?php
        if ($category_result->num_rows > 0) {
            while($row = $category_result->fetch_assoc()) {
                echo "<option value='" . $row["id"] . "'>" . $row["name"] . "</option>";
            }
        }
        ?>
    </select>
    <br><br>
    <label for="new_name">New Name:</label>
    <input type="text" id="new_name" name="new_name" required>
    <br><br>
    <input type="submit" value="Update">
</form>

</body>
</html>

<?php
$conn->close();
?>