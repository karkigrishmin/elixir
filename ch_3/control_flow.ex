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
end
