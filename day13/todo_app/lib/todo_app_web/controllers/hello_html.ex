defmodule TodoAppWeb.HelloHTML do
  use TodoAppWeb, :html

  embed_templates "hello_html/*"
end
