defmodule M do
  def main do
    # name = IO.gets("What is your name? ") |> String.trim()
    # IO.puts("Hello #{name}")
    data_stuff()
  end

  def data_stuff do
    # my_int = 16
    # IO.puts("Integer #{is_integer(my_int)}")
    my_float = 2.13
    IO.puts("Float #{is_float(my_float)}")
  end
end
