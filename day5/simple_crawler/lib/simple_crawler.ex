defmodule SimpleCrawler do
  @moduledoc """
  Documentation for `SimpleCrawler`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> SimpleCrawler.hello()
      :world

  """
  def main(filename) do
    lists = IO.gets("input url:")
    |> String.split("/")
    |> url_check()
    |> get_url()

    lists
    |> get_texts()
    |> zip_puts(lists)
    |> write!(filename)
  end

  def get_url(domain \\ "https://thewaggletraining.github.io/") do
    html = HTTPoison.get!(domain)

    Floki.parse_document!(html.body)
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> Enum.filter(& String.starts_with?(&1, domain))
  end

  def get_text(url) do
    html = HTTPoison.get!(url)

    Floki.parse_document!(html.body)
    |> Floki.find("body")
    |> Floki.text()
  end

  def get_texts(list) do
    Enum.map(list, & get_text(&1))
    |> Enum.map(& String.replace(&1, [" ", "\n"], ""))
  end

  def zip_puts(texts, lists) do
    Enum.zip(lists, texts)
    |> Enum.map(fn {x1, x2} -> "#{x1},#{x2}\n" end)
  end

  def write!(lists, filename) do
    File.open!(filename, [:write])
    |> IO.binwrite(lists)
  end

  def url_check([http , _ , domain | _ ] = url) do
    http <> "//" <> domain
  end
end
