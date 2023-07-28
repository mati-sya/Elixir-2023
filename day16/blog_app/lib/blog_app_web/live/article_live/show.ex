defmodule BlogAppWeb.ArticleLive.Show do
  use BlogAppWeb, :live_view

  alias BlogApp.Articles
  alias BlogApp.Articles.Comment

  def render(assigns) do
    ~H"""
    <div :if={@article.status == 2}>
      This is a limited article.
    </div>
    <div>
      <a href={~p"/accounts/profile/#{@article.account_id}"}>
        <%= @article.account.name %>
      </a>
      <div><%= @article.submit_date %></div>
      <div>Liked:<%= Enum.count(@article.likes) %></div>
      <h2><%= @article.title %></h2>
      <div><%= @article.body %></div>
      <%
        # この記事に対していいねしていない人
        # アカウントにログインしている人
        # この記事に作成者ではない人

        # ---
        # この記事にいいねした人
        # アカウントにログインしていない人
        # この記事の作成者
      %>
      <div
        phx-click="like_article"
        phx-value-account_id={@current_account_id}
        :if={
          @current_account &&
          @current_account_id != @article.account_id &&
          @current_account_id not in Enum.map(@article.likes, & &1.account_id)
        }
      >
        Like
      </div>
    </div>

    <div class="mt-4">
      <h3>Comments</h3>
      <div :for={comment <- @article.comments} class="mt-2 border-b">
        <a href={~p"/accounts/profile/#{comment.account_id}"}><%= comment.account.name %></a>
        <div><%= Calendar.strftime(comment.inserted_at, "%c") %></div>
        <div><%= comment.body %></div>
      </div>

      <.simple_form
        for={@form}
        phx-change="comment_validate"
        phx-submit="comment_save"
        :if={@current_account != @article.account_id and @current_account}
      >
        <.input field={@form[:body]} type="textarea" placeholder="Enter a comment." />
        <:actions>
          <.button phx-disabled-with="Submitting...">Submit</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"article_id" => article_id}, _uri, socket) do
    article = Articles.get_article!(article_id)

    socket =
      unless article.status == 0 do
        current_account_id =
          Map.get(socket.assigns.current_account || %{}, :id)

        socket
        |> assign(:article, article)
        |> assign_form(Articles.change_comment(%Comment{}))
        |> assign(:current_account_id, current_account_id)
        |> assign(:page_title, article.title)
      else
        # redirect to / if article's status is 0
        redirect(socket, to: ~p"/")
      end

    {:noreply, socket}
  end

  # makes it possible to write comment in box without error
  def handle_event("comment_validate", %{"comment" => params}, socket) do
    cs = Articles.change_comment(%Comment{}, params)

    {:noreply, assign_form(socket, cs)}
  end

  # make it possible to post comment
  def handle_event("comment_save", %{"comment" => params}, socket) do
    params =
      Map.merge(
        params,
        %{
          "account_id" => socket.assigns.current_account.id,
          "article_id" => socket.assigns.article.id
        }
      )

    # => %{"body" => "コメント", "account_id" => 2, "article_id" => 1}

    socket =
      case Articles.create_comment(params) do
        {:ok, article} ->
          socket
          |> put_flash(:info, "Comment created successfully.")
          |> assign(:article, Articles.get_article!(socket.assigns.article.id))
          |> assign_form(Articles.change_comment(%Comment{}))

        {:error, cs} ->
          assign_form(socket, cs)
      end

    {:noreply, socket}
  end

  # makes it possible to like article
  def handle_event("like_article", %{"account_id" => account_id}, socket) do
    Articles.create_like(socket.assigns.article.id, account_id)
    article = Articles.get_article!(socket.assigns.article.id)

    {:noreply, assign(socket, :article, article)}
  end

  defp assign_form(socket, cs) do
    assign(socket, :form, to_form(cs))
  end
end
