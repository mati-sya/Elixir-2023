defmodule TodoAppWeb.TaskHTML do
  use TodoAppWeb, :html

  embed_templates "task_html/*"

  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  # give func component name "task_form"
  def task_form(assigns)
end
