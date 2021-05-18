require 'rails_helper'

describe 'Admin registers instructors' do 
  it 'from index page' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_link('Cadastrar Professor', href: new_instructor_path)
  end

  it 'successfully' do
    visit root_path
    click_on 'Professores'
    click_on 'Cadastrar Professor'  

    fill_in 'Nome', with: 'Girafales'
    fill_in 'Email', with: 'chaves@gmail.com'
    fill_in 'Descrição', with: 'Instructor de tudo na turma do chaves'
    attach_file('Foto de perfil', Rails.root.join('spec', 'tmp', 'storage', 'girafales.jpg'))
    
    click_on 'Salvar'

    expect(page).to have_content('Girafales')
    expect(page).to have_content('chaves@gmail.com')
    expect(page).to have_link('Voltar', href: instructors_path)
  end

  it 'and attributes cannot be blank' do
    visit root_path
    click_on 'Professores'
    click_on 'Cadastrar Professor'

    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'Descrição', with: ''

    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and email must be unique' do
    instructor = Instructor.create!(name: 'Girafales', email: 'chaves@gmail.com', bio: 'Instructor de tudo na turma do chaves')
    instructor.profile_picture.attach(io: File.open(Rails.root.join('spec', 'tmp', 'storage', 'girafales.jpg')), filename: 'girafales.jpg', content_type: 'image/jpeg')

    visit root_path
    click_on 'Professor'
    click_on 'Cadastrar Professor'

    fill_in 'Email', with: 'chaves@gmail.com'

    click_on 'Salvar'

    expect(page).to have_content('já está em uso')
  end

  it 'and edit instructor' do
    instructor = Instructor.create!(name: 'Girafales', email: 'chaves@gmail.com',
                   bio: 'Instructor de tudo na turma do chaves')
                    
    instructor.profile_picture.attach(io: File.open(Rails.root.join('spec', 'tmp', 'storage', 'girafales.jpg')), filename: 'girafales.jpg', content_type: 'image/jpeg')
    
    visit root_path
    click_on 'Professores' 
    click_on 'Girafales'
    click_on 'Editar'

    fill_in('Nome', with: 'Seu madruga')
    fill_in('Email', with: 'madruga@gmail.com')


    click_button('Salvar')

    expect(page).to have_content('Seu madruga')
    expect(page).to have_content('madruga@gmail.com')
    expect(page).to have_content('Instructor de tudo na turma do chaves')
  end
end