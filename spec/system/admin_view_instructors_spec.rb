require 'rails_helper'
require 'byebug'

describe 'Admin view instructors' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Girafales', email: 'chaves@gmail.com',
                   bio: 'Instructor de tudo na turma do chaves')
                    
    instructor.profile_picture.attach(io: File.open(Rails.root.join('spec', 'tmp', 'storage', 'girafales.jpg')), filename: 'girafales.jpg', content_type: 'image/jpeg')
    
    visit root_path
    click_on 'Professores'  
    

    expect(page).to have_content('Girafales')
    expect(page).to have_content('chaves@gmail.com')
  end

  it 'and view details' do
    instructor = Instructor.create!(name: 'Girafales', email: 'chaves@gmail.com', bio: 'Instructor de tudo na turma do chaves')
     
    instructor.profile_picture.attach(io: File.open(Rails.root.join('spec', 'tmp', 'storage', 'girafales.jpg')), filename: 'girafales.jpg', content_type: 'image/jpeg')

    visit root_path
    click_on 'Professores'  
    click_on 'Girafales'

    expect(page).to have_content('Instructor de tudo na turma do chaves')
    expect(instructor.profile_picture).to be_attached
  end

  it 'create new instructor' do
    visit root_path
    click_on 'Professores'  
    click_on 'Cadastrar Professor'
    
    fill_in('Nome', with: 'Raimundinho')
    fill_in('Email', with: 'raimundinho@gmail.com')
    fill_in('Descrição', with: 'Professor de quimica e fisica, fanático por viagem no tempo')
    attach_file(Rails.root.join('spec', 'tmp', 'storage', 'einstein.jpg'), id: 'instructor_profile_picture')
    
    click_button('Salvar')

    expect(page).to have_content('Raimundinho')
    expect(page).to have_content('raimundinho@gmail.com')
  end

  #TODO: fail created with name/email empty or duplicate email

  it 'edit instructor' do
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
  end

  #TODO: fail edit with name/email empty or duplicate email

  it 'destroy instructor' do
    instructor = Instructor.create!(name: 'Girafales', email: 'chaves@gmail.com',
                   bio: 'Instructor de tudo na turma do chaves')
                    
    instructor.profile_picture.attach(io: File.open(Rails.root.join('spec', 'tmp', 'storage', 'girafales.jpg')), filename: 'girafales.jpg', content_type: 'image/jpeg')
    
    visit root_path
    click_on 'Professores' 

    expect { click_link('Excluir') }.to change(Instructor, :count).by(-1)
  end
end
