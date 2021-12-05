defmodule AdventOfCode.DayOne do
  @moduledoc """
  Solutions for Day One of Advent of Code 2021.
  """

  @doc """
  Given a List of integers, outputs an integer referring to how many list
  entries are greater than the previous.

  ## Examples

      iex> AdventOfCode.DayOne.depth_counter([1, 1, 1])
      0

      iex> AdventOfCode.DayOne.depth_counter([1, 2, 3])
      2

      iex> AdventOfCode.DayOne.depth_counter([3, 2, 1])
      0

      iex> AdventOfCode.DayOne.depth_counter([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
      7
  """
  def depth_counter(depths)

  @spec depth_counter(list(integer())) :: integer()
  def depth_counter([head | tail]) do
    depth_counter(tail, head, 0)
  end

  @spec depth_counter(list(integer()), integer(), integer()) :: integer()
  def depth_counter([head | tail], prev, count) do
    if head > prev do
      depth_counter(tail, head, count + 1)
    else
      depth_counter(tail, head, count)
    end
  end

  def depth_counter([], _, acc) do
    acc
  end

  @doc """
  Takes a list of integers and converts into a list of sums of each three-entry
  window.

  Used as part of the day one, part two solution.

  ## Examples

      iex> AdventOfCode.DayOne.build_sums([1, 1, 1, 1, 1])
      [3, 3, 3]

      iex> AdventOfCode.DayOne.build_sums([1, 2, 3, 4, 5])
      [6, 9, 12]

      iex> AdventOfCode.DayOne.build_sums([5, 4, 3, 2, 1])
      [12, 9, 6]

      iex> AdventOfCode.DayOne.build_sums([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
      [607, 618, 618, 617, 647, 716, 769, 792]
  """
  @spec build_sums(list(integer())) :: list(integer())
  def build_sums(depths) do
    build_sums(depths, [])
  end

  @spec build_sums(list(integer()), list(integer())) :: list(integer())
  def build_sums([_ | tail] = [first, second, third | _], acc) do
    build_sums(tail, [first + second + third] ++ acc)
  end

  def build_sums([_, _], acc) do
    Enum.reverse(acc)
  end

  def parse_input(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end
