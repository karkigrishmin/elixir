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

# type system
# Numbers, atoms, atoms as booleans
defmodule NumbersExample do
  def sum do
    a = 5
    b = 2
    a + b
  end

  def div_example do
    a = 7
    b = 3
    # returns integer value ie.2, but 7/3 gives float value i.e. 2.5
    div(a, b)
  end

  def remainder_example do
    # returns remainder i.e 1
    rem(7, 3)
  end
end

# atoms
# atoms consists of two parts- text and value
# text is the character after colon and text is stored in atom table at runtime
# value is the reference of the atom table that is stored in the variable
defmodule AtomsExample do
  def print_atom do
    a = :an_atom
    # we can use this syntax for spaces in our atom name
    b = :"an atom with spaces"
    # a
    b
  end
end

# aliases-another syntax for atom constants
defmodule AnotherAtomSyntax do
  def another_syntax_for_atom do
    a = AnAtom
    # at compile time it's transformed into :"Elixir.AnAtom"
    a == :"Elixir.AnAtom"
  end

  def test_atom do
    a = AnAtom
    # when we use alias, elixir implicitly adds Elixir. prefix to its text and
    # inserts and atom there
    a == Elixir.AnAtom
  end
end

# atoms as booleans
# there is no dedicated boolean type in elixir so we use :true and :false atoms
# as booleans
# elixir also allows us to reference these atoms without colon- true and false
defmodule BooleanAtomsExample do
  def example_1 do
    a = true
    b = false
    # returns true
    a
    # returns false
    b
  end

  def example_2 do
    # returns false
    true and false
    # returns true
    true or false
    # returns false
    not true
  end
end

# Nil
# another atom i.e :nil or nil
# elixirs short circuit operators- ||, &&, and !
defmodule ShortCircuitOperatorExample do
  def example_1 do
    # returns first expression that is not falsy value, so here it returns 5
    nil || 5 || false || true
    # returns last expression if there are no any truthy value
    nil || false || false
  end

  def example_2 do
    # returns first expression if it is not truthy
    nil && true
    # returns second expression if the first expression is truthy
    true && false
  end
end

# Tuples
# appropriate for grouping a small, fixed number of elements together
defmodule TupleExample do
  def example_1 do
    person = {"Harry", 20}
    # extracting an element of tuple
    elem(person, 1)
  end

  def example_2 do
    student = {"Hari", 19}
    # modify an element of tuple
    # put_elem function doesn't modify the tuple, it returns the
    # new version of tuple, keeping the old one unchanged
    put_elem(student, 1, 22)
  end
end

# Lists
defmodule ListExample do
  def example_1 do
    prime_numbers = [2, 3, 5, 7]
    # returns length of the list
    length(prime_numbers)

    # access an element of the list
    Enum.at(prime_numbers, 1)

    # check if 2 is available in the list or not
    2 in prime_numbers

    # modify an element of the specified position in the list
    # returns new modified list
    List.replace_at(prime_numbers, 0, 1)

    # insert an element at specified position(list, index, value)
    List.insert_at(prime_numbers, 0, 1)
    List.insert_at(prime_numbers, 2, 4)

    # to insert an element at the end, we specify negative value for the position
    List.insert_at(prime_numbers, -1, 9)
    List.insert_at(prime_numbers, -2, 6)

    # ++ operator is used to concatenate two lists
    [1, 2, 3] ++ [4, 5]
  end

  def recursive_nature_of_list do
    # list can be represented by a pair(head, tail)
    # head is the first element of the list
    # tail is the pair(head, tail) of remaining elements of the list
    # special syntax to support recursive list definition is [head | tail]
    # head can be of any type
    # tail is itself a list
    # some examples
    [1 | []]
    [1]
    [1 | [2 | []]]
    [1 | [2]]
    [1 | [2, 3, 4]]
    # this is the canonical recursive definition of a list
    [1 | [2 | [3 | [4 | []]]]]

    # returns head of the list i.e 1
    hd([1, 2, 3, 4])
    # returns tail of the list i.e [2, 3, 4]
    tl([1, 2, 3, 4])
  end
end

# Immutability
# data in elixir are immutable

# Maps
# a map is a key/value store
defmodule MapExample do
  def example_1 do
    # an empty map can be created with %{}
    empty_map = %{}
    empty_map

    # a map with some values
    squares = %{1 => 1, 2 => 4, 3 => 9}
    squares

    # we can also create a map by passing
    # enumerable which contains tuples of size two
    Map.new([{1, 1}, {2, 4}, {3, 9}])

    # to fetch a value at the given key
    squares[2]
    # returns nil because no value is associated with the given key i.e 4
    squares[4]

    # this works same as the above code but only the difference is
    # in this function we can also specify default value and
    # it is returned when the key is not found in a map
    Map.get(squares, 2)
    # returns default value i.e :not_found as key 4 is missing
    # but that returned default value is little confusing to distinguish that
    # either it is the value that is associated with given key
    # or it is the default value
    Map.get(squares, 4, :not_found)

    # it returns {:ok, value} if the key is found
    Map.fetch(squares, 2)
    # it returns :error as the key is not found in a map
    # helps to easily distinguish both the cases like
    # if the key we're searching is present or not
    Map.fetch(squares, 4)

    # it only returns value if the key is in the map
    # otherwise throws an exception
    Map.fetch!(squares, 2)
    # it throws an exception
    # Map.fetch!(squares, 4)

    # storing new element to the map
    new_squares = Map.put(squares, 4, 16)
    # fetching value at the given key
    new_squares[4]
  end

  def structured_data do
    # creating a map that represents a single person
    grish = %{:name => 'Grish', :age => 20, :studies_at => 'NCIT'}
    grish

    # in the above code keys are atom so we can write this way too
    grish = %{name: 'Grish', age: 20, studies_at: 'NCIT'}
    grish

    # accessing value of the given key i.e :name
    grish[:name]
    # with the atom key we can use the below syntax as well to fetch the value
    # and if the key is absent then we'll get an error
    grish.name

    grishmin = %{grish | name: 'Grishmin'}
    grish
  end
end

# Binaries
# a binary is a chunk of bytes
defmodule BinariesExample do
  def example_1 do
    # below code creates 3-byte binary
    <<1, 2, 3>>
    <<256>>
    <<257>>

    # we can also concatenate two binaries with <> operator
    <<1, 2, 3>> <> <<4, 5>>
  end
end

# Strings
# Elixir don't have a dedicated string type
# instead, strings are represented by using either a binary or a list type
defmodule StringsExample do
  def binary_string_example do
    # we can use strings by specifying them with the double-quotes syntax
    name = "Grishmin"
    name

    # Elixir provides support for embedded string expressions
    # we use #{} to place an Elixir expression in a string constant
    "sum of 2 and 3 is #{2 + 3}"

    # Elixir provides another syntax for declaring strings, so-called sigils
    # in this approach we enclose string inside ~s()
    ~s(This is also a string)
    # sigils is useful if we want to add quotes in our string
    ~s("Practice makes man perfect." -unknown)

    # we can concatenate strings with <> operator as they are binaries
    "Hello" <> " " <> "world"
  end

  # we can also represent strings in lists type
  def character_lists_example do
    # representing strings using single-quote syntax
    # this creates a character lists, where each elements in the list are integers
    # and each represents a single character
    'Harry Potter'

    # as mentioned in the above comment, this list of integers returns the string
    # 'ABC'
    [65, 66, 67]

    # we can also perform string interpolation and character list sigils same as
    # we have done above in binary strings

    # in general we should prefer binary strings over character lists
    # as most of the operations from string module won't work with character lists
  end
end

# First-class functions
defmodule AnonymousFunctionExample do
  def example_1 do
    # here function isn't bound to a global name, it's also called an anonymous
    # function or a lambda
    # no need of paranthesis in a argument list
    square = fn x ->
      x * x
    end

    square.(2)

    # functions can be passed as arguments to other functions
    # print_elements = fn x -> IO.puts(x) end

    # Enum.each(
    #   [1, 2, 3],
    #   print_elements
    # )

    # we can directly pass lambda as arguments
    Enum.each(
      [4, 5, 6],
      fn x -> IO.puts(x) end
    )

    # use of & operator also known as capture operator
    # with the use of & operator, it shorten the lambda definition
    Enum.each(
      [7, 8, 9],
      &IO.puts/1
    )

    # use of capture operator(&)
    lambda = fn x, y, z -> x + y * z end

    # we can write the above function as
    # it returns 7 as (1 + 2 * 3 = 7)
    lambda = &(&1 + &2 * &3)
    lambda.(1, 2, 3)
  end

  def closures_example do
    # a lambda can reference any variable from the outside scope
    outside_var = 5

    my_lambda = fn -> IO.puts(outside_var) end

    # rebinding a variable doesn't affect the previously defined lambda
    outside_var = 6
    # returns 5
    my_lambda.()
  end
end

# Higher-level types
defmodule HigherLevelTypes do
  # range
  def range_example do
    range = 1..2
    # using in operator, we can check whether any number falls in that range or not
    2 in range

    # ranges are enumerable, so we can use the functions from Enum module
    Enum.each(
      range,
      &IO.puts/1
    )
  end

  # Keyword lists
  def keyword_list_example do
    # it contains two-element tuple
    # first element of each tuple must be an atom
    # second element can be of any type
    days = [{:monday, 1}, {:tuesday, 2}, {:wednesday, 4}]

    # elixir allows this syntax too for defining a keyword list
    days = [monday: 1, tuesday: 2, wednesday: 4]

    Keyword.get(days, :monday)
    Keyword.get(days, :saturday)

    # just as maps we can also use [] operator to fetch a value
    days[:tuesday]

    # elixir allows us to omit the square brackets if the last argument is a keyword list
    IO.inspect([1, 2, 3], width: 1, limit: 1)
  end
end

# MapSet
defmodule MapSetExample do
  def example_1 do
    # creates a mapset instance
    days = MapSet.new([:sunday, :monday, :tuesday, :wednesday])
    days

    # checks the presence of an element
    # returns true
    MapSet.member?(days, :sunday)
    # returns false
    MapSet.member?(days, :noday)

    # puts a new elements to the MapSet
    days = MapSet.put(days, :thursday)

    # as MapSet is also an enumerable, we can pass it to functions from the Enum module
    Enum.each(
      days,
      &IO.puts/1
    )
  end
end

# Times and Dates
defmodule DateTimeExample do
  def example_1 do
    # creating date with the ~D sigil
    date = ~D[2021-05-20]
    date.year
    date.month

    # creating time with the ~T sigil
    time = ~T[14:00:10]
    time.hour

    # creating datetime using NaiveDateTime module
    naive_datetime = ~N[2021-05-20 14:00:10.0002]
    naive_datetime.year
  end
end

# Operators
defmodule OperatorsExample do
  def example_1 do
    # arithmetic operators
    3 + 2
    # returns float value
    4 / 2
  end

  def example_2 do
    # comparison operators
    # weak equality(==)
    3 == 3.0
    # strict equality(===)
    3 === 3.0
  end

  def example_3 do
    # logical operators
    true and false
    true or false
    not true

    # shortcircuit operators
    # returns second expression if the first expression is truthy else
    # returns first expression
    3 > 2 && "3 is greater"
    # returns first expression which is truthy otherwise returns last expression
    3 > 2 || 2 > 1 || 2 < 1
  end
end

# Macros
# here defmodule, def are macros
# macros are called at compile time, transforms and produces alternative code
defmodule MacroExample do
  def macro_function do
    # block1
  end

  # unless is also macro and in the compile time this code is transformed into if..else
  unless some_expression do
    # block1
  else
    # block2
  end
end
