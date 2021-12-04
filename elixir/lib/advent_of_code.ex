defmodule AdventOfCode do
  @moduledoc """
  Solutions for 2021 Advent of Code.
  """

  @doc """
  The solution to part one of day one.

  Given a List of integers, outputs an integer referring to how many list
  entries are greater than the previous.

  ## Examples

      iex> AdventOfCode.depth_counter([1, 2, 3])
      2

      iex> AdventOfCode.depth_counter([3, 2, 1])
      0

      iex> AdventOfCode.depth_counter([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
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
end
