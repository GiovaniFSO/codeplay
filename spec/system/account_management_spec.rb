require 'rails_helper'

describe 'Account management' do 
  context 'registration' do
    it 'with email and password' do  
      visit root_path
      click_on 'Registrar-se'
      fill_in 'Email', with: 'giovani@gmail.com'
      fill_in 'Senha', with: 'codeplay'
      fill_in 'Confirmação de Senha', with: 'codeplay'
      click_on 'Criar conta'

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('giovani@gmail.com')
      expect(page).to have_link('Cursos')
      expect(page).to_not have_link('Registrar-se')
      expect(page).to have_link('Sair')
    end 

    xit 'without valid field'
    xit 'with email not unique'
    xit 'password not match confirmation'
  end 

  context 'sign in' do 
    it 'with email and password' do
      User.create!(email: 'giovani@gmail.com', password: 'codeplay')
      
      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'giovani@gmail.com'
      fill_in 'Senha', with: 'codeplay'
      within 'form' do 
        click_on 'Entrar'
      end

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('giovani@gmail.com')
      expect(page).to have_link('Cursos')
      expect(page).to_not have_link('Registrar-se')
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end
  end

  context 'logout' do 
    it '' do
      user = User.create!(email: 'giovani@gmail.com', password: 'codeplay')
      
      login_as user, scope: :user
      visit root_path
      click_on 'Sair'

      expect(page).to have_text('Saiu com sucesso')
      expect(page).to_not have_text('giovani@gmail.com')
      expect(page).to have_link('Cursos')
      expect(page).to have_link('Registrar-se')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end
  
end