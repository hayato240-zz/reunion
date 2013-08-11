class CreateStudyAbroads < ActiveRecord::Migration
  def change
    create_table :study_abroads do |t|
      t.string :school_name
      t.date :study_from
      t.date :study_to

      t.timestamps
    end
  end
end
