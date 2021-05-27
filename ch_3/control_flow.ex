# Pattern matching
# the = operator in a = 1 isn't an assignment operator
# = operator is called the match operator and the assignment-like
# expression is an example of pattern matching

# Match operator
defmodule MatchOperatorExample do
  def example_1 do
    # in this example, we think that person is bound to tuple
    # but in reality something complex is going on here
    # At runtime, the left side of the = operator is matched to the right side
    # The left side is called a pattern
    # whereas on the right side we have an expression that evaluates to an elixir term.
    # In this example, we match the variable person to the right-side term{"Harry", 20}
    # A variable always matches to the right-side term,
    # and it becomes bound to the value of that term.
    person = {"Harry", 20}

    # pattern matching of tuples
    # this expression assumes that the right side term is a tuple of two elements.
    # when this expression is evaluated,
    # the variables, name and age are bound to the corresponding elements of tuple.
    {name, age} = {"Harry", 20}
    name
    age

    # the match expression also returns a value
    # and that value is the right side term that we're matching against
    {name, age} = {"Harry", 22}
  end

  def return_tuple_from_function do
    # this feature is useful when we call a function that returns a tuple
    # and we want to bind individual elements of that tuple to separate variables.
    # following example calls the Erlang function :calender.local_time/1
    # to get the current date and time
    {date, time} = :calendar.local_time()
    # the date and time are also tuples, which we can further decompose:
    # if the right-side doesn't corresponds to the pattern, the match fails
    # and an error is raised.
    {year, month, day} = date
    {hour, minute, second} = time
    year
    hour
  end

  def matching_constants do
    # we can also put constants on the leftside of the match expression
    # here pattern 1 matches to the term 1 and
    # the result of the entire expression is the right-side term
    1 = 1

    person = {:person, "John", 19}
    # here we expect the right-side term to be a three-element tuple
    # after the match, name and age are bound to the corresponding elements of tuple
    # in the right-side term
    {:person, name, age} = person
    name
    age

    # many functions from elixir or erlang return either {:ok, result}
    # or {:error, reason}
    # we can read the file contents with the help of File.read/1 function
    # so here we are attempting to open and read the file
    # if it succeeds, the file contents are extracted to the variable contents
    # if it fails, an error is raised
    # because the result of File.read() is a tuple in the form {:error, reason}
    # so the match to {:ok, contents} fails
    {:ok, contents} = File.read("../test.ex")
  end

  def variables_in_patterns do
    # varible name in the left-side pattern
    # always matches to the corresponding right-side pattern
    # and the variable is bound to the value of the term
    # if we dont want the value from the right-side term
    # but we still need to match on it, in this case
    # we can use the anonymous variable(_)
    # in the following example, we only need time, we specify time variable to store it
    # the value of the term isn't bound to anonymous variable
    {_, time} = :calendar.local_time()
    time

    # we can also add a descriptive name after undersccore character
    # _date is regarded as an anonymous variable
    {_date, time} = :calendar.local_time()
    _date

    # patterns can be arbitrarily nested
    # we can only retrieve the current hour of a day
    {_, {hour, _, _}} = :calendar.local_time()
    hour

    # a  variable can be referenced multiple times in the same pattern.
    # matches a tuple with three identical elements
    {amount, amount, amount} = {127, 127, 127}
    # fails because the tuple elements aren't identical
    # {amount, amount, amount} = {127, 127, 1}

    # if we need to match against the contents of the variable
    # for this purpose, we use pin operator(^)
    expected_name = "Harry"
    {^expected_name, _} = {"Harry", 20}
    # notice that, pin operator(^) doesn't bind the variable
  end

  def matching_lists do
    # list matching works similarly to tuples
    [first, second, third] = [1, 2, 3]
    # the previously mentioned pattern techniques work as well:
    [1, second, third] = [1, 2, 3]

    [first, _, third] = [1, 2, 3]

    first = 1
    [^first, second, third] = [1, 2, 3]

    [first, first, first] = [1, 1, 1]

    # matching list is more often done relying on their recursive nature
    [head | tail] = [1, 2, 3]
    head
    tail

    # if we only need one element of the [head, tail] pair, we can use hd function
    hd([1, 2, 3])
    # the pattern [head | _] is more useful when pattern-matching function arguments
  end

  def matching_maps do
    # to match a map, the following syntax can be used
    %{name: name, age: age} = %{name: "Harry", age: 20}
    name
    age
    # the left-side pattern doesn't need to contain all the keys from the right-side term
    %{age: age} = %{name: "Harry", age: 20}
    age
  end

  def matching_bitstrings_and_binaries do
    # matching binary
    binary = <<1, 2, 3>>
    <<b1, b2, b3>> = binary
    b1
    b2
    b3

    # extracting first byte into one variable and rest of the binary into another
    # rest::binary states that we expect an arbitrary-sized binary
    <<b1, rest::binary>> = binary
    b1
    rest
  end

  def matching_binary_strings do
    # strings are binaries in elixir
    # so we can use binary matches to extract individual bits and bytes from a string
    <<b1, b2, b3>> = "ABC"
    b1
    b2
    b3

    # a more useful pattern is to match the beginning of the string
    command = "ping www.ex.com"
    # in the pattern we write "ping" <> url = command
    # we expect that command variable is a binary string
    # staring with "ping "
    # thus it matches and the rest of the string is bound to url
    "ping " <> url = command
    url
  end

  def compound_matches do
    # patterns can be arbitrarily nested
    # here we are matching with the list of three elements
    # and we are only extracting the name of the second person, if list gets matched
    [_, {name, _}, _] = [{"Harry", 20}, {"John", 21}, {"Bob", 19}]
    name

    # match chaining
    # general form of match expression is
    # pattern = expression
    # match expressions can be chained
    # example
    # here firstly, the expression 1 + 2 is evaluated
    # and the result 3 is matched against the pattern b
    # and the result of inner match is matched against the pattern a
    # so both a and b have the value 3
    a = b = 1 + 2
    a
    b

    # another example
    # this function returns {{2020, 04, 20}, {hr, min, sec}}
    date_time = {_, {hour, _, _}} = :calendar.local_time()
    date_time
    hour

    # we can even swap the ordering
    # it still gives the same result
    {_, {hour, _, _}} = date_time = :calendar.local_time()
    date_time
    hour
  end
end

defmodule MatchingWithFunctions do
  # in case of function, arguments in the function definiton
  # are patterns and the expression i.e provided during the function call
  # is the term
  # here patterns assume that function is called with two elements tuple
  def rectangle({a, b}) do
    a * b
  end

  defmodule MultiClauseFunctions do
    # elixir allows us to overload a function
    # by specifying multiple clauses.
    # A clause is a function definition specified by the def construct
    # if we provide multiple definitions of the same function with the same arity
    # its said that the function has multiple clauses
    # here we have three clauses of same function i.e area
    # which calculates area of rectangle, circle and square
    # here first clause expects argument like this
    # {:rectangle, 2, 2}
    def area({:rectangle, a, b}) do
      a * b
    end

    # second clause can be called with this argument
    # {:square, 2}
    def area({:square, a}) do
      a * a
    end

    # third clause can be called with this argument
    # {:circle, 3}
    def area({:circle, r}) do
      r * r * 3.14
    end

    # fourth clause
    # this clause handles any invalid input
    # returns two element tuple to indicate that something has gone wrong
    def area(unknown) do
      {:error, {:unknown_shape, unknown}}
    end
  end

  def using_capture_operator do
    # using capture operator(&) we can create the function value
    # here we capture all of the clauses of area
    fun = &MultiClauseFunctions.area/1
    fun.({:square, 2})
    fun.({:circle, 3})
    # this calls fourth clause
    # as the argument of other clause didnt matched
    # returns this {:error, {:unknown_shape, {:triangle, 5}}}
    fun.({:triangle, 5})
  end
end
