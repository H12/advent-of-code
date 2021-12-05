defmodule AdventOfCode do
  @moduledoc """
  The AdventOfCode namespace.
  """

  alias AdventOfCode.{DayOne, DayTwo}

  @doc """
  The solution to Day One Part One.
  """
  def solve_part_one(input) do
    input
    |> DayOne.parse_input()
    |> DayOne.depth_counter()
  end

  @doc """
  The solution to Day One Part Two.
  """
  def solve_part_two(input) do
    input
    |> DayOne.parse_input()
    |> DayOne.build_sums()
    |> DayOne.depth_counter()
  end

  @doc """
  The solution to Day Two Part One.
  """
  def day_two_part_one(input) do
    pos =
      input
      |> DayTwo.parse_input()
      |> DayTwo.calculate_position()

    elem(pos, 0) * elem(pos, 1)
  end

  @doc """
  The solution to Day Two Part Two.
  """
  def day_two_part_two(input) do
    pos =
      input
      |> DayTwo.parse_input()
      |> DayTwo.calculate_position_with_aim()

    elem(pos, 0) * elem(pos, 1)
  end
end
