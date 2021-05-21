require 'rails_helper'

describe 'Admin updates courses' do
  it 'successfully' do
    instructor = Instructor.create!(name: "Girafales", email: "chaves@gmail.com")

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)

    visit course_path(course)
    click_on 'Editar'

    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de RoR'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '30'
    select "#{instructor.name} - #{instructor.email}", from: 'Instrutor(a)'
    fill_in 'Data limite de matrícula', with: Date.current.strftime('%d/%m/%Y')

    click_on 'Atualizar'

    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de RoR')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content(Date.current.strftime('%d/%m/%Y'))
    expect(page).to have_content('Curso atualizado com sucesso')
  end  

  #TODO : edit instructor
end