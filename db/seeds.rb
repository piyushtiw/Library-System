# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'

University.create({name: "North Carolina State University", id:1, created_at: DateTime.now, updated_at: DateTime.now })
University.create({name: "Duke University", id:2, created_at: DateTime.now, updated_at: DateTime.now})

Library.create({id:1, name: 'Hunt', location: 'on-campus', overdue_fines:10, fine: 10, university_id:1, max_borrow_days: 10, created_at: DateTime.now, updated_at: DateTime.now })
Library.create({id:2, name: 'Fox', location: 'on-campus', overdue_fines:20, fine: 20, university_id:2, max_borrow_days: 7, created_at: DateTime.now, updated_at: DateTime.now })
Library.create({id:3, name: 'Hill', location: 'off-campus', overdue_fines:30, fine: 30, university_id:1, max_borrow_days: 20, created_at: DateTime.now, updated_at: DateTime.now })

User.create(user_type: 'student', first_name: "Vivek Reddy", last_name: "Karri", email: "vivekreddy@gmail.com", education_level: 0, password: "123456", university_id:2)
User.create(user_type: 'student', first_name: "Tushar", last_name: "Kundra", email: "tushakundra@gmail.com", education_level: 1, password: "123456", university_id:1)
User.create(user_type: 'student', first_name: "Piyush", last_name: "Tiwari", email: "piyush@bigbinary.com", education_level: 1, password: "123456", university_id:1)
User.create(user_type: 'student', first_name: "Steve", last_name: "Rogers", email: "Steve@gmail.com", education_level: 1, password: "123456", university_id:2)
User.create(user_type: 'student', first_name: "Zing Zang", last_name: "Zu", email: "zzz@gmail.com", education_level: 2, password: "123456", university_id:2)
User.create(user_type: "librerian", first_name: "librarian 1", email: "lib1@librarian.com", password: "123456", library_id: 1)
User.create(user_type: "librerian", first_name: "librarian 2", email: "lib2@librarian.com", password: "123456", library_id: 2)
User.create(user_type: "librerian", first_name: "librarian 2", email: "lib3@librarian.com", password: "123456", library_id: 3)

Book.create({isbn: 123456, title: "GDM", number_of_copies: 4, available_books: 4, authors: "Samatova Nagizha , Kanchana Padmanabham", language: "english", published_date: "01/01/1998", \
            edition: 1, subject: "GDM", summary: "vhcchgvhhgvhgvv", library_id: 1, special_collection:true, created_at: DateTime.now, updated_at: DateTime.now })
Book.create({isbn: 123457, title: "GDM", number_of_copies: 1, available_books: 1, authors: "Samatova Nagizha , Kanchana Padmanabham", language: "english", published_date: "01/01/1998", \
            edition: 1, subject: "GDM", summary: "vhcchgvhhgvhgvv", library_id: 2, special_collection:true, created_at: DateTime.now, updated_at: DateTime.now})
Book.create({isbn: 123458, title: "DBMS", number_of_copies: 2, available_books: 2, authors: "Kemafor Ogan", language: "english", published_date: "01/01/1998", \
            edition: 2, subject: "DBMS", summary: "vhcchgvhhgvhgvv", library_id: 2, created_at: DateTime.now, updated_at: DateTime.now})
Book.create({isbn: 123459, title: "Algorithms", number_of_copies: 5, available_books: 5, authors: "Cormen", language: "english", published_date: "01/01/1998", \
            edition: 2, subject: "DA", summary: "vhcchgvhhgvhgvv", library_id: 3, created_at: DateTime.now, updated_at: DateTime.now})
Book.create({isbn: 123460, title: "IR", number_of_copies: 1, available_books: 1, authors: "Sudip Sanyal", language: "english", published_date: "01/01/1998", \
            edition: 1, subject: "Information Retrieval", summary: "vhcchgvhhgvhgvv", special_collection:true, library_id: 1, created_at: DateTime.now, updated_at: DateTime.now})
Book.create({isbn: 123461, title: "Theory of Relativity", number_of_copies: 1, available_books: 1, authors: "Einstein", language: "german", published_date: "01/01/1934", \
            edition: 1, subject: "TR", summary: "vhcchgvhhgvhgvv", library_id: 1, created_at: DateTime.now, updated_at: DateTime.now})
Book.create({isbn: 123462, title: "Paralell Systems", number_of_copies: 1, available_books: 1, authors: "Frank Mueller", language: "english", published_date: "01/01/1998", \
            edition: 1, subject: "PAralell", summary: "vhcchgvhhgvhgvv", library_id: 3, created_at: DateTime.now, updated_at: DateTime.now})
Book.create({isbn: 123463, title: "Computer Networks", number_of_copies: 1, available_books: 1, authors: "Roudra Dutta", language: "english", published_date: "01/01/1998", \
            edition: 1, subject: "CN", summary: "vhcchgvhhgvhgvv", library_id: 2, created_at: DateTime.now, updated_at: DateTime.now})
Book.create({isbn: 123464, title: "NLP", number_of_copies: 1, available_books: 1, authors: "Muninder P Singh", language: "english", published_date: "01/01/1998", \
            edition: 4, subject: "NLP", summary: "vhcchgvhhgvhgvv", library_id: 1, created_at: DateTime.now, updated_at: DateTime.now})
Book.create({isbn: 123462, title: "ESaas", number_of_copies: 2, available_books: 2, authors: "Armando Fox , David Patterson", language: "english", published_date: "01/01/1998", \
            edition: 1, subject: "OODD", summary: "vhcchgvhhgvhgvv", library_id: 1, special_collection:true, created_at: DateTime.now, updated_at: DateTime.now})

