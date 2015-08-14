feature 'User sign up' do

  # Strictly speaking, the tests that check the UI
  # (have_content, etc.) should be separate from the tests
  # that check what we have in the DB since these are separate concerns
  # and we should only test one concern at a time.

  # However, we are currently driving everything through
  # feature tests and we want to keep this example simple.
  # let(:user) { FactoryGirl.build(:user) }
  let(:user_wrong_confirmation) { FactoryGirl.build(:user_wrong_confirmation)}
  let(:user_no_email) { FactoryGirl.build(:user_no_email)}

  scenario 'I can sign up as a new user' do
    user = build(:user)
    expect { sign_up_as(user) }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, #{user.email}")
    expect(User.first.email).to eq(user.email)
  end

  scenario 'with a password that does not match' do
    user = build(:user, password_confirmation: "wrong")
    expect { sign_up_as(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users') # current_path is a helper provided by Capybara
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'requires e-mail for sign-up' do
    user = build(:user, email: "")
    expect { sign_up_as(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Email must not be blank Email must not be blank'
  end

  def sign_up_as(user)
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email,    with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end

end
