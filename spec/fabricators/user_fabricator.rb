# Uses fabrication gem to create objects
# creates an instance of class User with name, etc. attributes
Fabricator(:user) do
  name     'Test User'
  email    'example@example.com'
  password 'changeme'
  password_confirmation 'changeme'
  # required if the Devise Confirmable module is used
  # confirmed_at Time.now
end
