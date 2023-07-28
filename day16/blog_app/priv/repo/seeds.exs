alias BlogApp.Repo
alias BlogApp.Accounts.Account
alias BlogApp.Articles.Article
alias BlogApp.Articles.Comment
alias BlogApp.Articles.Like

params = [
  {"user01", "user01@sample.com", "user01999"},
  {"user02", "user02@sample.com", "user02999"},
  {"user03", "user03@sample.com", "user03999"}
]

[a01, a02, a03] =
  Enum.map(params, fn {name, email, password} ->
    Repo.insert!(
      %Account{
        name: name,
        email: email,
        hashed_password: Pbkdf2.hash_pwd_salt(password),
        confirmed_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
      }
    )
  end)

article =
  Repo.insert!(
    %Article{
      title: "初めての投稿",
      body: """
      初めての投稿です。
      よろしくお願いします。
      """,
      status: 1,
      submit_date: Date.utc_today(),
      account_id: a01.id
    }
  )

Repo.insert!(
  %Comment{
    body: """
    初めまして#{a01.name}さん!!
    """,
    account_id: a02.id,
    article_id: article.id
  }
)

Repo.insert!(
  %Comment{
    body: """
    よろしくお願いします。
    """,
    account_id: a03.id,
    article_id: article.id
  }
)

Repo.insert!(
  %Article{
    title: "#{a02.name}です",
    body: """
    初めまして、#{a02.name}です。
    よろしくお願いします。
    """,
    status: 1,
    submit_date: Date.utc_today(),
    account_id: a02.id
  }
)

Repo.insert!(
  %Article{
    title: "限定記事です",
    body: """
    これは限定記事です。
    URLを知っている人のみ見れます。
    """,
    status: 2,
    submit_date: Date.utc_today(),
    account_id: a01.id
  }
)

Repo.insert!(
  %Article{
    title: "下書き記事です",
    body: """
    これは下書き記事です。
    作成者のみ見れます。
    """,
    status: 0,
    account_id: a01.id
  }
)

Enum.each([a02, a03], fn account ->
  Repo.insert!(
    %Like{
      account_id: account.id,
      article_id: article.id
    }
  )
end)
