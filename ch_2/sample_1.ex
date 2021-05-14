# function
# the return value of function is the return value of its last expression
# there is no explicit return in elixir
defmodule Geometry do
  def rectangle_area(a, b) do
    a * b
  end
end

# function can also be defined in a single line if a function definition is short
defmodule Geometry.V2 do
  def square_area(a), do: a * a
end

# Pipline operator(|>)
# It is used to place the result of previous function call as the first argument
# of next call.
defmodule PiplineExample do
  def rectangle_area(a, b) do
    a * b
  end

  def area(a) do
    rectangle_area(a, a)
    |> IO.puts()
  end
end

# function arity
# It denotes the number of arguments a fuction receives
# two functions with the same name but different arities are two different functions
defmodule ArityExample do
  # this area function is denoted as ArityExample.area/1
  def area(a) do
    area(a, a)
  end

  # this area function is denoted as ArityExample.area/2
  def area(a, b) do
    a * b
  end
end

# elixir also allows us to specify default values for a function arguments
# by using \\ operator followed by default value
defmodule DefaultValueExample do
  def sum(a, b \\ 2) do
    a + b
  end
end

# function visibility
defmodule TestPrivate do
  # this double function is public and can be called from anywhere
  # In elixir terminology, this function is said to be exported
  def double(a) do
    sum(a, a)
  end

  # this sum function is private and can be used only inside this module
  defp sum(a, b) do
    a + b
  end
end

# Imports
# we can import other module into our own module where we want to use functions
# from that other module
defmodule MyModule do
  import IO

  def my_function do
    puts("we can use puts instead of IO.puts")
  end
end

# alias
# It can be used to reference a module under a different name
defmodule AliasExample do
  alias IO, as: MyIO

  def use_alias_module do
    MyIO.puts("giving another name for IO as MyIO")
  end
end
