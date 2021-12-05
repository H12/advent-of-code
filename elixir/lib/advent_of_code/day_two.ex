defmodule AdventOfCode.DayTwo do
  @moduledoc """
  Solutions for Day Two of Advent of Code 2021.
  """

  @typedoc """
  Either :down, :up, or :forward.
  """
  @type direction() :: :down | :up | :forward

  @typedoc """
  Representation of a movement command.

  The first element is a direction, and the second is an integer representing a
  unit of distance.
  """
  @type movement() :: {direction(), integer()}

  @typedoc """
  A tuple of two integers, representing horizontal position and depth,
  respectively.
  """
  @type position() :: {integer(), integer()}

  @doc """
  Calculates the relative position after executing the provided list of
  movements.

  It returns a tuple containing the horizontal, and vertical positions,
  respectively.

  ## Examples

      iex> AdventOfCode.DayTwo.calculate_position([{:up, 1}, {:forward, 3}, {:down, 5}])
      {3, 4}

      iex> AdventOfCode.DayTwo.calculate_position([{:up, 5}, {:forward, 3}, {:down, 1}])
      {3, -4}
  """
  @spec calculate_position(list(movement())) :: position()
  def calculate_position(movements) do
    Enum.reduce(movements, {0, 0}, &apply_movement/2)
  end

  defp apply_movement({:forward, dist}, {x, y}), do: {x + dist, y}
  defp apply_movement({:down, dist}, {x, y}), do: {x, y + dist}
  defp apply_movement({:up, dist}, {x, y}), do: {x, y - dist}

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&to_movement_tuple/1)
  end

  defp to_movement_tuple(movement_str) do
    [dir, dist] = String.split(movement_str)

    {String.to_atom(dir), String.to_integer(dist)}
  end
end
