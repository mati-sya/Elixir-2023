defmodule BlogAppWeb.AccountPageLive do
  use BlogAppWeb, :live_view

  alias BlogApp.Accounts
  alias BlogApp.Articles

  def render(assigns) do
    ~H"""
    <div class="border-2 rounded-lg px-2 py-4">
      <div class="text-lg font-bold"><%= @account.name %></div>
      <div class="text-sm text-gray-600"><%= @account.email %></div>
      <div class="whitespace-pre-wrap my-2 border-b pb-2"><%= @account.introduction %></div>
      <div>Articles count:<%= @articles_count %></div>
      <a
        href={~p"/accounts/settings"}
        class="rounded-lg bg-gray-200 py-1 px-4 block mt-2 w-1/5 text-center"
        :if={@account.id == @current_account_id}
      >
        Edit profile
      </a>
    </div>

    <div>
      <div class="border-b-2 my-2 flex gap-2 items-center">
        <a href={~p"/accounts/profile/#{@account.id}"} class={tabs_class(@live_action, :info)}>Articles</a>
        <a href={~p"/accounts/profile/#{@account.id}/draft"} class={tabs_class(@live_action, :draft)} :if={@account.id == @current_account_id}>
          Draft
        </a>
        <a href={~p"/accounts/profile/#{@account.id}/liked"} class={tabs_class(@live_action, :liked)}>Liked</a>
      </div>

      <div>
        <%= if length(@articles) > 0 do %>
          <div :for={article <- @articles} class="mt-2 border-b last:border-b-0 pb-2 mt-2 cursor-pointer flex justify-between">
            <div>
              <a href={~p"/accounts/profile/#{article.account.id}"} class="hover:underline">
                <%= article.account.name %>
              </a>
              <a href={~p"/articles/show/#{article.id}"} :if={@live_action in [:info, :liked]}>
                <div class="text-xs text-gray-600"><%= article.submit_date %></div>
                <h2 class="text-2xl font-bold my-2 hover:underline"><%= article.title %></h2>
                <div>Liked:<%= Enum.count(article.likes) %></div>
              </a>

              <a href={~p"/articles/#{article.id}/edit"} :if={@live_action == :draft}>
                <h2 class="text-2xl font-bold my-2 hover:underline"><%= article.title %></h2>
                <div :if={article.body}><%= String.slice(article.body, 0..30) %></div>
              </a>
            </div>

            <div :if={@live_action in [:info, :draft]} class="relative">
              <div
                phx-click="set_article_id"
                phx-value-article_id={article.id}
                class="border rounded w-min px-1 mt-2"
                :if={@account.id == @current_account_id}
              >
                ...
              </div>
              <div :if={article.id == @set_article_id} class="absolute right-0 border rounded-lg mt-2 p-2 bg-white z-10">
                <a href={~p"/articles/#{article.id}/edit"} class="block border-b pb-2 hover:underline">Edit</a>
                <span
                  phx-click="delete_article"
                  phx-value-article_id={article.id}
                  class="block mt-2 hover:underline"
                >
                  Delete
                </span>
              </div>
            </div>
          </div>
        <% else %>
          <div class="text-xl font-bold mt-2">
            <%=
              case @live_action do
                :info -> "No articles"
                :draft -> "No draft articles"
                :liked -> "No liked articles"
                _ -> ""
              end
            %>
          </div>
        <% end %>
      </div>
    </div>

    <.modal :if={@live_action in [:edit, :confirm_email]} id="account_settings" show on_cancel={JS.patch(~p"/accounts/profile/#{@account.id}")}>
      <.live_component module={BlogAppWeb.AccountSettingsComponent} id={@live_action} current_account={@current_account} />
    </.modal>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"account_id" => account_id}, _uri, socket) do
    current_account = socket.assigns.current_account
    current_account_id = get_current_account_id(current_account)

    socket =
      socket
      |> assign(:account, Accounts.get_account!(account_id))
      |> assign(:set_article_id, nil)
      |> assign(:current_account_id, current_account_id)
      |> apply_action(socket.assigns.live_action)

    {:noreply, socket}
  end

  def handle_params(%{"token" => token}, _uri, socket) do
    socket =
      case Accounts.update_account_email(socket.assigns.current_account, token) do
        :ok ->
          put_flash(socket, :info, "Email changed successfully.")

        :error ->
          put_flash(socket, :error, "Email change link is invalid or it has expired.")
      end

    {:noreply, push_navigate(socket, to: ~p"/accounts/profile/#{socket.assigns.current_account.id}")}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, apply_action(socket, :edit)}
  end

  # private function called in handle_params
  defp apply_action(socket, :info) do
    account = socket.assigns.account
    current_account_id = socket.assigns.current_account_id

    articles =
      Articles.list_articles_for_account(account.id, current_account_id)

    socket
    |> assign(:articles, articles)
    |> assign(:articles_count, Enum.count(articles))
    |> assign(:page_title, account.name)
  end

  defp apply_action(socket, :edit) do
    account = socket.assigns.current_account

    socket
    |> assign(:account, account)
    |> assign(:set_article_id, nil)
    |> assign(:current_account_id, account.id)
    |> assign(:articles, [])
    |> assign_article_count(account.id, account.id)
    |> assign(:page_title, "account settings")
  end

  defp apply_action(socket, :draft) do
    account = socket.assigns.account
    current_account_id = socket.assigns.current_account_id

    if account.id == current_account_id do
      socket
      |> assign(:articles, Articles.list_draft_articles_for_account(current_account_id))
      |> assign_article_count(account.id, current_account_id)
      |> assign(:page_title, account.name <> " - draft")
    else
      redirect(socket, to: ~p"/accounts/profile/#{account.id}")
    end
  end

  defp apply_action(socket, :liked) do
    account = socket.assigns.account
    current_account_id = socket.assigns.current_account_id

    socket
    |> assign(:articles, Articles.list_liked_articles_for_account(account.id))
    |> assign_article_count(account.id, current_account_id)
    |> assign(:page_title, account.name <> " - liked")
  end

  defp apply_action(socket, :liked) do
    account = socket.assigns.account
    current_account_id = socket.assigns.current_account_id

    socket
    |> assign(:articles, Articles.list_liked_articles_for_account(account.id))
    |> assign_article_count(account.id, current_account_id)
    |> assign(:current_account_id, current_account_id)
    |> assign(:page_title, account.name <> " - liked")
  end

  # priv func called in apply_action
  defp get_current_account_id(current_account) do
    Map.get(current_account || %{}, :id)
  end

  defp assign_article_count(socket, account_id, current_account_id) do
    articles_count =
      account_id
      |> Articles.list_articles_for_account(current_account_id)
      |> Enum.count()

    assign(socket, :articles_count, articles_count)
  end

  def handle_info({:update_email, account}, socket) do
    socket =
      socket
      |> put_flash(:info, "A link to confirm your email change has been sent to the new address.")
      |> redirect(to: ~p"/accounts/profile/#{account.id}")

    {:noreply, socket}
  end

  def handle_info({:update_profile, account}, socket) do
    socket =
      socket
      |> put_flash(:info, "Account profile updated successfully.")
      |> redirect(to: ~p"/accounts/profile/#{account.id}")

    {:noreply, socket}
  end

  def handle_info({:update_password, account}, socket) do

  end

  def handle_event("set_article_id", %{"article_id" => article_id}, socket) do
    id =
      unless article_id == "#{socket.assigns.set_article_id}" do
        String.to_integer(article_id)
      else
        nil
      end

    {:noreply, assign(socket, :set_article_id, id)}
  end

  def handle_event("delete_article", %{"article_id" => article_id}, socket) do
    socket =
      case Articles.delete_article(Articles.get_article!(article_id)) do
        {:ok, _article} ->
          assign_article_when_deleted(socket, socket.assigns.live_action)

        {:error, _cs} ->
          put_flash(socket, :error, "Could not article.")
      end

    {:noreply, socket}
  end

  defp assign_article_when_deleted(socket, :info) do
    articles =
      Articles.list_articles_for_account(
        socket.assigns.account.id,
        socket.assigns.current_account_id
      )

    socket
    |> assign(:articles, articles)
    |> assign(:articles_count, Enum.count(articles))
    |> put_flash(:info, "Article deleted successfully.")
  end

  defp assign_article_when_deleted(socket, :draft) do
    socket
    |> assign(
      :articles,
      Articles.list_draft_articles_for_account(socket.assigns.current_account_id)
    )
    |> put_flash(:info, "Draft article deleted successfully.")
  end

  @tabs_class ~w(rounded-t-lg text-xl block p-2)
  defp tabs_class(live_action, action) when live_action == action do
    Enum.join(@tabs_class ++ ~w(bg-gray-400), " ") # => "rounded-t-lg text-xl block p-2 bg-gray-400"
  end

  defp tabs_class(_live_action, _action) do
    Enum.join(@tabs_class ++ ~w(bg-gray-200 hover:bg-gray-400), " ")
    # => "rounded-t-lg text-xl block p-2 bg-gray-200 hover:bg-gray-400"
  end
end
