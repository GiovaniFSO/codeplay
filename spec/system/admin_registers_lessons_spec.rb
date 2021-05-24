require 'rails_helper'

describe 'Admin register lessons' do
  it 'successfully' do
    instructor = Instructor.create!(name: "Girafales", email: "chaves@gmail.com")
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)

    visit course_path(course)
    click_on 'Cadastrar aula'

    fill_in 'Nome', with: 'Duck Typing'
    fill_in 'Duração', with: 10
    fill_in 'Conteúdo', with: 'Uma aula mto legal'
    click_on 'Cadastrar'

    expect(page).to have_text('Duck Typing')
    expect(page).to have_text('10 minutos')
    expect(page).to have_text('Aula cadastrada com sucesso')
    expect(current_path).to eq(course_path(course))
  end  
end