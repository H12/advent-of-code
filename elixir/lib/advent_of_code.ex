defmodule AdventOfCode do
  @moduledoc """
  The AdventOfCode namespace.
  """

  alias AdventOfCode.{DayOne, DayTwo, DayThree}

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

  @doc """
  The solution to Day Three Part One.
  """
  def day_three_part_one(input) do
    input_list = DayThree.parse_input(input)

    DayThree.get_gamma(input_list) * DayThree.get_epsilon(input_list)
  end

  @doc """
  The solution to Day Three Part Two.
  """
  def day_three_part_two(input) do
    input_list = DayThree.parse_input(input)

    DayThree.get_o2_rating(input_list) * DayThree.get_co2_rating(input_list)
  end
end
