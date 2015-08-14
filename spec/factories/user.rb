FactoryGirl.define do

  factory :user do # FactoryGirl will assume that the parent model of a factory named ":user" is "User".
    email 'alice@example.com'
    password 'secret1234'
    password_confirmation 'secret1234'

    # factory :user_wrong_confirmation do
    #   password_confirmation 'wrong'
    # end
    # factory :user_no_email do
    #   email ''
    # end
  end
end
