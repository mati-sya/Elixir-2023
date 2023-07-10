defmodule OriginalErr do
  defexception message: "default"
end
raise OriginalErr, message: "custom"
