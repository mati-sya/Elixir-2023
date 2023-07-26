alias HouseholdAccountBookApp.Repo
alias HouseholdAccountBookApp.Purchases.Category

categories = [
  {"住宅費", "#dc143c"},
  {"水道光熱費", "#00bfff"},
  {"通信費", "#f0e68c"},
  {"交通費", "#ee82ee"},
  {"食費", "#008000"},
  {"日用品", "#00fa9a"},
  {"医療費", "#ff7f50"},
  {"交際費", "#ff69b4"},
  {"娯楽費", "#4169e1"},
  {"雑費", "#9acd32"},
]

Enum.each(categories, fn {category_name, color_code} ->
  Repo.insert!(
    %Category{
      category_name: category_name,
      color_code: color_code
    }
  )
end)
