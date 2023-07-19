alias Example.Repo
alias Example.User

users = [
  {"Yamada", "Taro", 40},
  {"Sato", "Hanako", 38},
  {"Suzuki", "Jiro", 53}
]

for {last_name, first_name, age} <- users do
  user =
    %User{
      first_name: first_name,
      last_name: last_name,
      age: age,
      email: first_name <> "@sample.com"
    }

  # insert into DB
  Repo.insert(user)
end
