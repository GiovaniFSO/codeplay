require 'rails_helper'

describe 'Admin deletes courses' do
  it 'successfully' do
    instructor = Instructor.create!(name: "Girafales", email: "chaves@gmail.com")

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
   
    visit course_path(course)          
    click_on 'Apagar'
    
    expect(page).to have_text('Curso apagado com sucesso')
    
  end 
end