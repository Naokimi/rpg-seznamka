require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  # subject do
  #   described_class.new(
  #     name: 'Test User',
  #     email: 'test@mail.com',
  #     password: 'Password',
  #     role: (0..2).to_a.sample
  #   )
  # end

  # context 'valid' do
  #   it 'with valid attributes' do
  #     expect(subject).to be_valid
  #   end
  # end

  # context 'not valid' do
  #   it 'without a name' do
  #     subject.name = nil
  #     expect(subject).not_to be_valid
  #   end

  #   it 'without an email' do
  #     subject.email = nil
  #     expect(subject).not_to be_valid
  #   end

  #   it 'without a password' do
  #     subject.password = nil
  #     expect(subject).not_to be_valid
  #   end

  #   it 'without a role' do
  #     subject.role = nil
  #     expect(subject).not_to be_valid
  #   end
  # end

  # context 'relations' do
  #   let(:teacher)               { create(:teacher) }
  #   let(:classroom1)            { create(:classroom, user: teacher) }
  #   let(:classroom2)            { create(:classroom) }
  #   let(:classroom3)            { create(:classroom, user: teacher) }
  #   let(:student_a)             { create(:student) }
  #   let(:student_b)             { create(:student) }
  #   let!(:student_a_classroom1) { create(:student_classroom, user: student_a, classroom: classroom1) }
  #   let!(:student_b_classroom1) { create(:student_classroom, user: student_b, classroom: classroom1) }
  #   let!(:student_a_classroom2) { create(:student_classroom, user: student_a, classroom: classroom2) }

  #   it 'returns students of a teacher' do
  #     expect(teacher.students).to include(student_a)
  #     expect(teacher.students).to include(student_b)
  #     expect(teacher.students.size).to eq(2)
  #   end

  #   it 'return teachers of a student' do
  #     teacher2 = classroom2.teacher
  #     expect(student_a.teachers).to include(teacher)
  #     expect(student_a.teachers).to include(teacher2)
  #     expect(student_a.teachers.size).to eq(2)
  #   end

  #   it 'returns teacher classroom' do
  #     classroom3
  #     expect(teacher.classrooms).to include(classroom1)
  #     expect(teacher.classrooms).to include(classroom3)
  #     expect(teacher.classrooms.size).to eq(2)
  #   end

  #   it 'returns student classrooms' do
  #     expect(student_a.attending_classrooms).to include(classroom1)
  #     expect(student_a.attending_classrooms).to include(classroom2)
  #     expect(student_a.attending_classrooms.size).to eq(2)
  #   end
  # end
end
