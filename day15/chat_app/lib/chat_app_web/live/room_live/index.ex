defmodule ChatAppWeb.RoomLive.Index do
  use ChatAppWeb, :live_view

  alias ChatApp.Accounts
  alias ChatApp.Rooms
  alias ChatApp.Rooms.Room

  @impl true
  def mount(_params, session, socket) do
    account =
      Accounts.get_account_by_session_token(session["account_token"])

    socket =
      socket
      |> stream(:rooms, Rooms.list_rooms())
      |> assign(:current_account, account)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Room")
    |> assign(:room, Rooms.get_room!(id, socket.assigns.current_account.id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Room")
    |> assign(:room, %Room{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Rooms")
    |> assign(:room, nil)
  end

  @impl true
  def handle_info({ChatAppWeb.RoomLive.FormComponent, {:saved, %Room{id: id}}}, socket) do
    {:noreply, redirect(socket, to: ~p"/rooms/#{id}")}
  end

  @impl true
  def handle_event("join", %{"id" => room_id}, socket) do
    Rooms.join_room(socket.assigns.current_account.id, room_id)

    socket =
      socket
      |> put_flash(:info, "join room.")
      |> redirect(to: ~p"/rooms/#{room_id}")

    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    room = Rooms.get_room!(id, socket.assigns.current_account.id)
    {:ok, _} = Rooms.delete_room(room)

    {:noreply, stream_delete(socket, :rooms, room)}
  end
end
