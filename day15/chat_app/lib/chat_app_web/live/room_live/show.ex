defmodule ChatAppWeb.RoomLive.Show do
  use ChatAppWeb, :live_view

  alias ChatApp.Rooms
  alias ChatApp.Accounts
  alias ChatApp.Rooms.Message

  @impl true
  def mount(_params, session, socket) do
    account =
      Accounts.get_account_by_session_token(session["account_token"])

    {:ok, assign(socket, :current_account, account)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    socket =
      if room = Rooms.get_room!(id, socket.assigns.current_account.id) do
        if connected?(socket) do
          subscribe(room)
        end

        socket
        |> assign(:page_title, page_title(socket.assigns.live_action))
        |> assign(:room, room)
        |> assign(:messages, Rooms.list_messages(room.id))
        |> assign_form(Rooms.change_message(%Message{}))
      else
        socket
        |> put_flash(:error, "Not join room.")
        |> redirect(to: ~p"/rooms")
      end

    {:noreply, socket}
  end

  defp page_title(:show), do: "Show Room"
  defp page_title(:edit), do: "Edit Room"

  def handle_info({:send_message, message}, socket) do
    socket =
      update(socket, :messages, fn messages -> List.insert_at(messages, -1, message) end)

    {:noreply, socket}
  end

  @impl true
  def handle_event("send_message", %{"message" => %{"message" => ""}}, socket) do
    {:noreply, socket}
  end

  def handle_event("send_message", %{"message" => params}, socket) do
    params =
      Map.merge(params, %{
        "account_id" => socket.assigns.current_account.id,
        "room_id" => socket.assigns.room.id
      })

    socket =
      case Rooms.create_message(params) do
        {:ok, message} ->
          broadcast(message, :send_message)

          assign_form(socket, Rooms.change_message(%Message{}))

        {:error, cs} ->
          assign_form(socket, cs)
      end

    {:noreply, socket}
  end

  defp assign_form(socket, cs) do
    assign(socket, :message_form, to_form(cs))
  end

  # "room_1"
  defp subscribe(room) do
    Phoenix.PubSub.subscribe(ChatApp.PubSub, "room_#{room.id}")
  end

  defp broadcast(message, :send_message) do
    IO.puts("call broadcast")
    Phoenix.PubSub.broadcast(ChatApp.PubSub, "room_#{message.room_id}", {:send_message, message})
  end
end
