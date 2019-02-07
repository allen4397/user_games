require 'rails_helper'

RSpec.describe 'login', type: :feature do
  it 'shows a login form that asks for Full name, email and password' do
    visit new_user_path

    expect(page).to have_button('Create User')
    expect(page).to have_field("Name")
    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
  end

  it 'saves that information to the database and sends them to the login page' do
    visit new_user_path

    fill_in 'user[name]', with: "Tim Allen"
    fill_in 'user[email]', with: "allenexample@gmail.com"
    fill_in 'user[password]', with: "Passwordsarefun"
    click_button "Create User"

    expect(current_path).to eq(login_path)
  end

  it 'allows the user to login with the correct credentials and see secret' do
    User.create(name: "Tim", email: "allenexample@gmail.com", password: "Passwordsarefun")
    visit login_path

    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
    fill_in 'session[email]', with: "allenexample@gmail.com"
    fill_in 'session[password]', with: "Passwordsarefun"
    click_button "Login"

    click_link "Secret!"

    expect(current_path).to eq('/secret')

    click_link "Logout"

    expect(current_path).to eq(login_path)
  end

  it 'has a link to create a new account on the login page' do
    visit login_path

    click_link "Create Account"

    expect(current_path).to eq(new_user_path)
  end

  it 'has a splash page that takes you to the login page' do
    visit '/'

    click_link 'Login'

    expect(current_path).to eq(login_path)
  end
end
