namespace :one_timer do
  desc "Initialize data"
  task :initialize_data => :environment do
    # uni = University.create!(name: "North Carolina State University")

    # lib = Library.create!(name: "Hunt Library", location: "Centennial Campus", university_id: uni.id, max_borrow_days: 30, overdue_fines: 10)

    admin_user = User.create!(first_name: "admin", last_name: "user", email: "admin@user.com", password: "password", user_type: "admin")
  end
end
