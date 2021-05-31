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

    # Guards
    # we want to write a function that accepts a number and
    # returns an atom :negative, :zero, or :positive,
    # depending on the numbers value
    # this isn't possible with simple pattern matching.
    # Elixir gives us a solution for this in the form of guards
    # Guards are an extension of the basic pattern-matching mechanism.
    # they allow us to state additional broader expectations
    # that must be satisfied for the entire pattern to match.
    # A guard can be specified by providing the when clause
    # after the argument list
    defmodule TestNum do
      # first clause will be called
      # only if we pass a negative number.
      # extending guard to test whether the argument is a number
      # now none of the clause gets called with non-number type argument.
      def test(x) when is_number(x) and x < 0 do
        :negative
      end

      def test(0), do: :zero

      # it is called only
      # if we pass a positive number.
      def test(x) when is_number(x) and x > 0 do
        :positive
      end

      def call_above_functions do
        # returns :negative
        test(-1)
        # returns :zero
        test(0)
        # returns :positive
        test(1)
        # it also returns :positive
        # in elixir we can compare elixir terms with operators > and <,
        # even if they are not of the same type.
        # In this case, the type ordering determines the result:
        # number < atom < reference < fun < port < pid < tuple < map < list < bitstring
        # A number is smaller than any other type,
        # so test/1 always returns :positive
        # as we have guard to check whether the argument is number or not
        # thats why an error will occur if we call with non-number.
        # test(:not_a_number)
      end
    end

    # in some cases, function used in a guard
    # may cause an error to be raised
    defmodule ListHelper do
      def smallest(list) when length(list) > 0 do
        Enum.min(list)
      end

      def smallest(_), do: {:error, :invalid_argument}

      def calling_above_functions do
        # returns 3
        smallest([10, 8, 3])
        # returns {:error, :invalid_argument}
        smallest([])
      end
    end
  end

  # Multiclause lambdas
  # Anonymous functions(lambdas) may also consist of multiple clauses
  defmodule MultiClauseLambdas do
    # the general lambda syntax has the following shape:
    # fn
    #   pattern1, pattern2 ->
    #     ....
    #   pattern3, pattern4 ->
    #     ...
    #   end
    def test_num do
      test_num = fn
        x when is_number(x) and x < 0 ->
          :negative

        0 ->
          :zero

        x when is_number(x) and x > 0 ->
          :positive
      end

      test_num.(3)
      test_num.(0)
      test_num.(-1)
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

# Conditionals
# elixir provides some standard ways of conditional branching,
# with constructs such as if and case.
# multiclause functions can be used for this purpose as well.
defmodule Conditionals do
  defmodule BranchingWithMulticlauseFunctions do
    defmodule TestNum do
      def test(x) when x > 0 do
        :positive
      end

      def test(0) do
        :zero
      end

      def test(x) do
        :negative
      end

      def call_above_functions do
        test(2)
        test(0)
      end
    end

    # following example is used to whether a given list is empty
    defmodule TestList do
      # this clause matches an empty list
      def empty?([]), do: true
      # this clause matches a non-empty list in the form of [head|tail]
      def empty?([_ | _]), do: false

      def call_above_functions do
        # returns true
        empty?([])
        # returns false
        empty?([1, 2, 3])
      end
    end

    # by relying on pattern matching
    # we can implement polymorphic functions
    # that do different things depending on the input type
    # the following example implements a function that doubles a variable.
    # the function behaves differently depending on
    # whether its called with a number or with a binary(string)
    defmodule Polymorphic do
      def double(x) when is_number(x), do: x * 2
      def double(x) when is_binary(x), do: x <> x

      def call_above_functions do
        # returns 4
        double(2)
        # returns "elixirelixir"
        double("elixir")
      end
    end

    defmodule ListHelper do
      def sum([]), do: 0
      def sum([head | tail]), do: head + sum(tail)

      def call_above_functions do
        # returns 6
        sum([1, 2, 3])
      end
    end
  end

  # Classical Branching Constructs
  defmodule ClassicalBranchingConstructs do
    # to use a classical branching construct in the function
    # macros if, unless, cond and case are provided

    # syntax of if macro
    # if condition do
    #   ....
    # else
    #   ....
    # end

    # above syntax can also be condensed as below
    # if condition, do: something, else: another_thing

    # everything in elixir is an expression
    # that has a return value
    # if expression returns the result of the executed block
    # if the condition isn't met and the else clause isn't specified
    # the return value is the atom nil
    def example do
      if 3 < 2 do
        "3 is less"
      else
        "3 is greater"
      end

      # returns nil
      if 2 > 4 do
        :first_block
      end

      # unless macro is also available
      # which is equivalent of if(not...)
      # returns :second
      unless 3 > 2 do
        :first_block
      else
        :second
      end

      # Cond
      # it is equivalent to an if-else-if pattern
      # it takes the list of expressions and
      # executes the block of first expression that evaluates to a truthy value

      # syntax
      # cond do
      #   expression_1 ->
      #     ...
      #   expression_2 ->
      #     ...
      #   ..
      # end

      # the result of cond is the result of the
      # corresponding executed block
      # if none of the conditions is satisfied, cond raises an error
      cond do
        4 > 2 ->
          4

        # equivalent of a default clause
        true ->
          2
      end

      # case
      # syntax
      # case expression do
      #   pattern_1 ->
      #     ...
      #   pattern_2 ->
      #     ...
      # end

      # the term pattern indicates that
      # it deals with pattern matching.
      # the provided expression is evaluated,
      # and then the result is matched against the given clauses
      # if no clause matches, an error is occured

      # example
      case 4 > 2 do
        true ->
          4

        false ->
          2

        # we can also specify default clause by using the anonymous variable
        # to match anything.
        _ ->
          "default"
      end
    end
  end
end
