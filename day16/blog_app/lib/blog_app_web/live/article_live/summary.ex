defmodule BlogAppWeb.ArticleLive.Summary do
  use BlogAppWeb, :live_view

  alias BlogApp.Articles

  # template
  def render(assigns) do
    ~H"""
    <.header>
      Listing Articles
    </.header>

    <div>
      <.simple_form for={@form} phx-change="search_articles">
        <.input
          field={@form["keyword"]}
          type="text"
          placeholder="Search articles"
        />
      </.simple_form>
    </div>

    <div :for={article <- @articles} class="mt-2 border-2 rounded-lg px-4 py-2 cursor-pointer">
      <a href={~p"/accounts/profile/#{article.account.id}"} class="hover:underline">
        <%= article.account.name %>
      </a>
      <a href={~p"/articles/show/#{article.id}"}>
        <div class="text-xs text-gray-600"><%= article.submit_date %></div>
        <h2 class="text-2xl font-bold hover:underline my-2"><%= article.title %></h2>
        <div>Liked:<%= Enum.count(article.likes) %></div>
      </a>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:articles, Articles.list_articles())
      # tab title of page
      |> assign(:page_title, "blog")
      |> assigns_form()

    {:ok, socket}
  end

  def handle_event(
    "search_articles",
    %{"search_article" => %{"keyword" => keyword}},
    socket) do

    socket =
      socket
      # @articles
      |> assign(:articles, Articles.search_articles_by_keyword(keyword))
      # @form
      |> assigns_form()

    {:noreply, socket}
  end

  # for adding search bar to page
  defp assigns_form(socket) do
    # @form
    assign(socket, :form, to_form(%{}, as: "search_article"))
  end
end
