defmodule Lab4 do
  @best_move []
  @moduledoc """
    Fill in the functions for lab 4 below. Fuction skeletons with dummy return values are provided.
    Your task is to fill in these functions to accomplish what is described in the lab description.
    You may also add additional helper functions if you desire.
    Hint: You'll need to add tail recursive signatures. See the MyEnum examples from class
    for examples of this.
    Test your code by running 'mix test' from the cps506_lab4 directory in a terminal.
  """

  def isAscending?(items) do
    Enum.all?(Enum.with_index(items), fn {element, index} -> index == 0 or element > List.last(Enum.slice(items, 0, index)) end)
  end

  @spec onlyOddDigits?(any) :: false
  def onlyOddDigits?(n) do
    IO.puts(n)
    isEven = fn(a) -> rem(a, 2) != 0 end
    if(div(n, 10) < 1) do
      isEven.(rem(n, 10))
    else
      if(!isEven.(rem(n, 10))) do
        false
      else
        onlyOddDigits?(div(n,10))
      end
    end
  end

  def fib(n, a, b) do
    if (n == 1) do
      a
    else
      fib(n-1, a + b, a)
    end
  end

  def tailFib(n) do
    if (n == 1 or n == 2) do
      1
    else
      fib(n, 1, 0)
    end
  end

  def giveChange(amount, coins) do
    Enum.reverse(giveChangeHelper(amount, coins, []))
  end

  defp giveChangeHelper(0, _coins, result) do
    result
  end

  defp giveChangeHelper(amount, [], _result) do
    :error
  end

  defp giveChangeHelper(amount, [coin], result) when amount < coin do
    :error
  end

  defp giveChangeHelper(_amount, [], _result) do
    :error
  end

  defp giveChangeHelper(amount, coins, result) do
    next_coin = hd(coins)
    if amount < next_coin do
      :error
    else
      if amount >= next_coin do
        giveChangeHelper(amount - next_coin, coins, [next_coin | result])
      else
        giveChangeHelper(amount, tl(coins), result)
      end
    end
  end

  def reduce(items, fun) do
    reduce(tl(items), hd(items), fun)
  end

  def reduce([], acc, _), do: acc
  def reduce([item | rest], acc, fun) do
    new_acc = fun.(item, acc)
    reduce(rest, new_acc, fun)
  end

  def reduce(items, acc, fun, init) do
    reduce(items, acc, fun)
  end

  def reduce([], acc, _, _), do: acc
  def reduce([item | rest], acc, fun, items) do
    new_acc = fun.(item, acc)
    reduce(rest, new_acc, fun, items)
  end

end
