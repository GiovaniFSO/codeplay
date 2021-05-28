require 'rails_helper'

describe 'Student view courses on homepage' do
  it 'courses with enrollment still available' do
    instructor = Instructor.create!(name: "Girafales", email: "chaves@gmail.com")

    available_course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: 1.month.from_now, instructor: instructor)

    unavailable_course = Course.create!(name: 'PHP', description: 'Um curso de PHP',
                   code: 'PHPBASIC', price: 12,
                   enrollment_deadline: 1.day.ago, instructor: instructor)    
            
    visit root_path
    
    expect(page).to have_content('Ruby')
    expect(page).to have_content(available_course.description)
    expect(page).to have_content('R$ 10,00')
    expect(page).to_not have_content('PHP')
    expect(page).to_not have_content(unavailable_course.description)
    expect(page).to_not have_content('R$ 12,00')
  end  

  xit 'and does not view enrollment '

  it 'and view enrollment link' do
    user = User.create!(email: 'giovani@gmail.com', password: 'codeplay')
    instructor = Instructor.create!(name: "Girafales", email: "chaves@gmail.com")

    available_course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: 1.month.from_now, instructor: instructor)
            
    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'

    expect(page).to have_content('Comprar')
  end  

  it 'must be signed in to enroll' do
    instructor = Instructor.create!(name: "Girafales", email: "chaves@gmail.com")

    available_course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: 1.month.from_now, instructor: instructor)
            
    visit root_path
    click_on 'Ruby'

    expect(page).to_not have_content('Comprar')
    expect(page).to have_content('Faça login para comprar este curso')
    expect(page).to have_link('login', href: new_user_session_path)
  end

  it 'and buy a course' do
    user = User.create!(email: 'giovani@gmail.com', password: 'codeplay')
    instructor = Instructor.create!(name: "Girafales", email: "chaves@gmail.com")

    available_course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: 1.month.from_now, instructor: instructor)

    other_course = Course.create!(name: 'Elixir', description: 'Um curso de Elixir',
                   code: 'ELIXIRBASIC', price: 10,
                   enrollment_deadline: 1.month.from_now, instructor: instructor)

    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'
    click_on 'Comprar'

    expect(page).to have_content('Curso comprado com sucesso')
    #expect(page).to_not have_link('Comprar')    
    expect(current_path).to eq my_courses_courses_path
    expect(page).to have_content('Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to_not have_content('Elixir')
  end

  it 'and cannot buy a course twice' do
    user = User.create!(email: 'giovani@gmail.com', password: 'codeplay')
    instructor = Instructor.create!(name: "Girafales", email: "chaves@gmail.com")

    available_course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: 1.month.from_now, instructor: instructor)
    Lesson.create!(name: 'Monkey Patch', course: available_course)
    Enrollment.create!(user: user, course: available_course)

    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'

    expect(page).to_not have_link('Comprar')    
    expect(page).to have_link('Monkey Patch')    
  end

end