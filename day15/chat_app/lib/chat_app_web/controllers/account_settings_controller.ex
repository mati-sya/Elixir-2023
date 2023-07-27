defmodule ChatAppWeb.AccountSettingsController do
  use ChatAppWeb, :controller

  alias ChatApp.Accounts
  alias ChatAppWeb.AccountAuth

  plug :assign_email_and_password_changesets

  def edit(conn, _params) do
    render(conn, :edit)
  end

  def update(conn, %{"action" => "update_email"} = params) do
    %{"current_password" => password, "account" => account_params} = params
    account = conn.assigns.current_account

    case Accounts.apply_account_email(account, password, account_params) do
      {:ok, applied_account} ->
        Accounts.deliver_account_update_email_instructions(
          applied_account,
          account.email,
          &url(~p"/accounts/settings/confirm_email/#{&1}")
        )

        conn
        |> put_flash(
          :info,
          "A link to confirm your email change has been sent to the new address."
        )
        |> redirect(to: ~p"/accounts/settings")

      {:error, changeset} ->
        render(conn, :edit, email_changeset: changeset)
    end
  end

  def update(conn, %{"action" => "update_password"} = params) do
    %{"current_password" => password, "account" => account_params} = params
    account = conn.assigns.current_account

    case Accounts.update_account_password(account, password, account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Password updated successfully.")
        |> put_session(:account_return_to, ~p"/accounts/settings")
        |> AccountAuth.log_in_account(account)

      {:error, changeset} ->
        render(conn, :edit, password_changeset: changeset)
    end
  end

  def confirm_email(conn, %{"token" => token}) do
    case Accounts.update_account_email(conn.assigns.current_account, token) do
      :ok ->
        conn
        |> put_flash(:info, "Email changed successfully.")
        |> redirect(to: ~p"/accounts/settings")

      :error ->
        conn
        |> put_flash(:error, "Email change link is invalid or it has expired.")
        |> redirect(to: ~p"/accounts/settings")
    end
  end

  defp assign_email_and_password_changesets(conn, _opts) do
    account = conn.assigns.current_account

    conn
    |> assign(:email_changeset, Accounts.change_account_email(account))
    |> assign(:password_changeset, Accounts.change_account_password(account))
  end
end
