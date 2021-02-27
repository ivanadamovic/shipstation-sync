# products
# [
#   { title: "Product 1", truncated_preview: "Nice!" },
#   { title: "Product 2", truncated_preview: "Great!" },
# ].each { |product|
#   Product.create(product)
# }

Student.delete_all
Club.delete_all

student = Student.create(name: "student 1")
club = Club.create(name: "club 1")
club.students << student

# student = Student.create(name: "student 2")
# student.clubs.create(name: "club 2")
# student.clubs.create(name: "club 3")
