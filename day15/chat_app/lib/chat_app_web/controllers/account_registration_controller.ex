defmodule ChatAppWeb.AccountRegistrationController do
  use ChatAppWeb, :controller

  alias ChatApp.Accounts
  alias ChatApp.Accounts.Account
  alias ChatAppWeb.AccountAuth

  def new(conn, _params) do
    changeset = Accounts.change_account_registration(%Account{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"account" => account_params}) do
    case Accounts.register_account(account_params) do
      {:ok, account} ->
        {:ok, _} =
          Accounts.deliver_account_confirmation_instructions(
            account,
            &url(~p"/accounts/confirm/#{&1}")
          )

        conn
        |> put_flash(:info, "Account created successfully.")
        |> AccountAuth.log_in_account(account)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
