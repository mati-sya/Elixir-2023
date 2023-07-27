defmodule ChatAppWeb.AccountRegistrationControllerTest do
  use ChatAppWeb.ConnCase, async: true

  import ChatApp.AccountsFixtures

  describe "GET /accounts/register" do
    test "renders registration page", %{conn: conn} do
      conn = get(conn, ~p"/accounts/register")
      response = html_response(conn, 200)
      assert response =~ "Register"
      assert response =~ ~p"/accounts/log_in"
      assert response =~ ~p"/accounts/register"
    end

    test "redirects if already logged in", %{conn: conn} do
      conn = conn |> log_in_account(account_fixture()) |> get(~p"/accounts/register")

      assert redirected_to(conn) == ~p"/"
    end
  end

  describe "POST /accounts/register" do
    @tag :capture_log
    test "creates account and logs the account in", %{conn: conn} do
      email = unique_account_email()

      conn =
        post(conn, ~p"/accounts/register", %{
          "account" => valid_account_attributes(email: email)
        })

      assert get_session(conn, :account_token)
      assert redirected_to(conn) == ~p"/"

      # Now do a logged in request and assert on the menu
      conn = get(conn, ~p"/")
      response = html_response(conn, 200)
      assert response =~ email
      assert response =~ ~p"/accounts/settings"
      assert response =~ ~p"/accounts/log_out"
    end

    test "render errors for invalid data", %{conn: conn} do
      conn =
        post(conn, ~p"/accounts/register", %{
          "account" => %{"email" => "with spaces", "password" => "too short"}
        })

      response = html_response(conn, 200)
      assert response =~ "Register"
      assert response =~ "must have the @ sign and no spaces"
      assert response =~ "should be at least 12 character"
    end
  end
end
