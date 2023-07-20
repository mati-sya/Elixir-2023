alias Example.Repo
alias Example.User

users = [
  {"Yamada", "Taro", 20},
  {"Sato", "Hanako", 18},
  {"Suzuki", "Jiro", 23},
  {"Sasaki", "Mami", 22},
  {"Ito", "Aki", 19},
  {"Yamaguti", "Atusi", 19},
  {"Sakamoto", "Hajime", 24},
  {"Akimoto", "Satosi", 17},
  {"Makimoto", "Riyu", nil}
]

for {last_name, first_name, age} <- users do
  user =
    %User{
      first_name: first_name,
      last_name: last_name,
      age: age,
      email: first_name <> "@sample.com"
    }

  Repo.insert(user)
end
