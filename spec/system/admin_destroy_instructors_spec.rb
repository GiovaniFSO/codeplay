require 'rails_helper'

describe 'Admin destroy instructor' do
  it 'from index page' do
    instructor = Instructor.create!(name: 'Girafales', email: 'chaves@gmail.com',
                   bio: 'Instructor de tudo na turma do chaves')
                    
    instructor.profile_picture.attach(io: File.open(Rails.root.join('spec', 'tmp', 'storage', 'girafales.jpg')), filename: 'girafales.jpg', content_type: 'image/jpeg')
    
    visit root_path
    click_on 'Professores'

    expect(page).to have_link('Excluir', href: instructor_path(instructor))
  end

  it 'successfully' do 
    instructor = Instructor.create!(name: 'Girafales', email: 'chaves@gmail.com',
                   bio: 'Instructor de tudo na turma do chaves')
                    
    instructor.profile_picture.attach(io: File.open(Rails.root.join('spec', 'tmp', 'storage', 'girafales.jpg')), filename: 'girafales.jpg', content_type: 'image/jpeg')
    
    visit root_path
    click_on 'Professores' 

    expect { click_link('Excluir') }.to change(Instructor, :count).by(-1)
  end
end