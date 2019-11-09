# README
# Library Management System

<h2>Functionalities</h2>
<ul>
	<li>
		<p>Facebook Signin:User can sign up using facebook. Default password will be "123456". Functionality works fine on local but not works on server as facebook public app verification is pending</p>
	</li>
	<li>
		<p>Mail SMTP : When a book is issued to the user, a conformation mail is sent.</p>
	</li>
	<li>Admin Role:
	  	<ul>
			<li>Login Details:
				EmailId:  admin@user.com</br>
				Password: password</br>
			</li>
			<li>Priviliges and Functionalities:
				<ul>
					<li>Edit profile</li>
					<li>Create/Modify Librarian or Student accounts</li>
					<li>Create/Modify/Delete Libraries and Books and University. The entryies will be marked inactive and user cannot ib future order a book that belonged to that university and library</li>
					<li>View the list of users and their profile details</li>
					<li>View the list of books</li>
		      			<li>View details of books.</li>
					<li>View the list of book hold requests.</li>
					<li>View the list of Checked out books.</li>
					<li>View the list of students with books overdue (along with overdue fines).</li>
					<li>View the borrowing history of each book.</li>
					<li>Delete Student/Book/Librarian from the system. Users will be marked inactive in the database.</li>
				</ul>
			</li>
	  	</ul>
	</li>
  	<li>Librarian Role:
		<ul>
			<li>Priviliges and Functionalities:
				<ul>
					<li>Log in with email and password.</li>
					<li>Edit their own profile to choose an existing library</li>
					<li>Edit library</li>
					<li>Add/Remove books to/from a library to which the librarian is assigned</li>
					<li>View & Edit book information.</li>
					<li>View all books ih his/her library</li>
					<li>View hold requests for any book in the library he/she works in.</li>
					<li>For books in the special collection, accept or deny book hold request.</li>
					<li>View list of all the books that are checked out from their library.</li>
					<li>View the borrowing history of the books from their library.</li>
					<li>View the list of students with overdue books from their library along with overdue fine</li>
				</ul>
			</li>
		</ul>
	</li>
	<li>Student Role:
		<ul>
			<li>Priviliges and Functionalities:
				<ul>
					<li>View the list of all the libraries</li>
					<li>Edit profile to modify email, name and password only.</li>
					<li>View all books associated with his/her university</li>
					<li>Check out/Request/Return a book from any library associated with their University.</li>
					<li>Delete a reservation request, which has not been approved yet (pending).</li>
					<li>View/Edit their account attributes (including changing their password).</li>
					<li>Search through the books</li>
					<li>Search by title</li>
					<li>Search by author</li>
					<li>Search by publication date</li>
					<li>Search by subject</li>
					<li>Bookmark a book they are interested in.</li>
					<li>View their bookmarked books.</li>
					<li>At any given time, a student can borrow a max of 'N' number of books based on their educational level.</li>
					<li>View the overdue fines on each book level.</li>
					<li>Receive an email when any of their book request is sucessful.</li>
				</ul>
			</li>
		</ul>
  	</li>
</ul>

<h2>Use Cases</h2>
<ul>
	<li>Book Deletion
		<p> When a book is deleted, it sis marked in the system as inactive. No user will be able to order that bokk. In case a user has already ordered a book and it is deleted later on, the user will still be able to see his hold request.</p>
	</li>
	<li>Library Deletion
		<p> When a library is deleted, it is marked in the system as inactive and all the book in the system for that library will also be marked a inactive.</p>
	</li>
  	<li>University Deletion
		<p> When a library is deleted, it is marked in the system as inactive and all the libraries and books in the system will also be marked a inactive.</p>
	</li>
	<li>Book Not Available
		<p>When a user requests a book his request is queued in the system, and whenever the book is available in the library the book is automaticlly assigned to the student and a confirmation mail is sent to the user</p>
	</li>
	<li>Librerian Unverified
		<p>The librerian can login if he/she is unverified but will not be able to see hold requests.</p>
	</li>
</ul>
<h2>Modules</h2>
<ul>
	<li>User Module "/user" User CRUD</li>
		<p>Admin can edit student and librerian from this page. he can also approve the librerians from the system.</p>
	<li>Order Module "/orders" User CRUD
		<p>The admin and librerian can see the book orders, history and fine on this page. Student will see the list of all the books and return books from this page</p>
	</li>
	<li>Gold Request Module "/hold_requests"
		<p>The admin and librerian can see the hold requests by clicking in the Hold Requests link on the home page. Student can also use this page to create ne hold request</p>
	</li>
</ul>
