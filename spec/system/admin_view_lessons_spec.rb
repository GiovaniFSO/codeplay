require 'rails_helper'

describe 'Admin view lessons' do
  it 'of a course' do
    instructor = Instructor.create!(name: "Girafales", email: "chaves@gmail.com")
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
    other_course = Course.create!(name: 'Rails', description: 'Um curso de Rails',
                   code: 'RAILSBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
    
    Lesson.create!(name: 'Classes e objetos', duration: 10, content: 'Uma aula de Ruby', course: course)
    Lesson.create!(name: 'Monkey Patch', duration: 20, content: 'Uma aula sobre Monkey Patch', course: course)               
    Lesson.create!(name: 'Aula para não ver', duration: 40, content: 'Uma aula sobre Monkey Patch', course: other_course)               

    visit course_path(course)

    expect(page).to have_link('Classes e objetos')
    expect(page).to have_content('10 minutos')
    expect(page).to have_link('Monkey Patch')
    expect(page).to have_content('20 minutos')
    expect(page).to_not have_content('Aula para não ver')
    expect(page).to_not have_content('40 minutos')
  end  

  it 'and view content - show lesson' do 
    instructor = Instructor.create!(name: "Girafales", email: "chaves@gmail.com")
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
              
    Lesson.create!(name: 'Classes e objetos', duration: 10, content: 'Uma aula de Ruby', course: course)              

    visit course_path(course)
    click_on 'Classes e objetos'

    expect(page).to have_text('Classes e objetos')
    expect(page).to have_text('Uma aula de Ruby')
    expect(page).to have_text('10 minutos')
  end


  it 'and does not have lesson' do 
    instructor = Instructor.create!(name: "Girafales", email: "chaves@gmail.com")
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)

    visit course_path(course)

    expect(page).to have_text('Nenhuma aula cadastrada')
  end
end