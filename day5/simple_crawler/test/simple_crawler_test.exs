defmodule SimpleCrawlerTest do
  use ExUnit.Case
  doctest SimpleCrawler

  test "greets the world" do
    assert SimpleCrawler.hello() == :world
  end
end
