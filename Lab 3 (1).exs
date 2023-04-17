defmodule Lab3 do
  def firstTwo(list) do
    hd(list) == hd(tl(list))
  end
  
  def evenSize(list) do
    rem(length(list), 2) == 0
  end

  def frontBack(list) do
   _list = tl(list) ++ [hd(list)]
  end

  def nextNineNine(list) do
    h_list = [hd(list)]
    r_list = tl(list)
    h_list ++ [99] ++ r_list
  end

  def isCoord(list) do
    is_integer(hd(list)) and is_integer(tl(list))
  end

  def sayHello(list) do
    Enum.any?(list, &(&1 == "Hello"))
  end

  def helloIfSo(list) do
    case sayHello(list) do
      true -> List.delete(list, "Hello") ++ ["Hello"]
      false -> list ++ ["Hello"] 
    end
  end
  
end

result = Lab3.helloIfSo([1, "Hello", 3])
IO.inspect result