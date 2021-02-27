class CreateStudentsClubs < ActiveRecord::Migration[6.1]
  def change
    create_table :students_clubs do |t|
      t.belongs_to :student
      t.belongs_to :club
    end
  end
end
