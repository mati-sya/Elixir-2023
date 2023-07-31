defmodule TodoAppWeb.TaskController do
  use TodoAppWeb, :controller

  alias TodoApp.Tasks
  alias TodoApp.Tasks.Task

  # (get) compare :index atom in router.ex
  def index(conn, _params) do
    # obtain tasks by calling self-defined function from TodoApp.Tasks
    tasks = Tasks.list_tasks()

    # "tasks: tasks" hands tasks to the template (needs to be keyword list)
    # :index --> task_html/index.html.heex
    render(conn, :index, tasks: tasks)
  end

  # (get) router.ex :new
  def new(conn, _params) do
    # changeset
    cs = Tasks.change_task(%Task{})

    # send changeset to new.html.heex
    render(conn, :new, changeset: cs)
  end

  # (post) router.ex :create
  # %{"task" => task_params} / tasks_params are value of Map with key "tasks"
  def create(conn, %{"task" => task_params}) do
    # function create_task in lib/todo_app/tasks.ex
    case Tasks.create_task(task_params) do
      # if registration was successful
      {:ok, task} ->
        conn
        |> put_flash(:info, "created task.")
        |> redirect(to: ~p"/tasks/#{task}")

      # if registratino was not successful
      {:error, cs} ->
        # send changeset to page new.html.heex
        render(conn, :new, changeset: cs)
    end
  end

  # (get) /tasks/{task_id}
  def show(conn, %{"id" => id}) do
    # get task from db
    task = Tasks.get_task!(id)

    # send task to show.html.heex
    render(conn, :show, task: task)
  end

  # (get)
  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    cs = Tasks.change_task(task)
    # send [task to change, changeset] to edit.html.heex
    render(conn, :edit, task: task, changeset: cs)
  end

  # (patch - modify), (put - send data to a server to create/update a resource)
  def update(conn, %{"id" => id, "task" => params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "updated task.")
        |> redirect(to: ~p"/tasks/#{task}")

      {:error, cs} ->
        # send task and changeset to edit.html.heex
        render(conn, :edit, task: task, changeset: cs)
    end
  end

  # (delete)
  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "deleted task.")
    |> redirect(to: ~p"/tasks")
  end
end
