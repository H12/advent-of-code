defmodule AdventOfCode.DayFour do
  @moduledoc """
  Solutions for Day Four of Advent of Code 2021.
  """

  @typedoc """
  The data structure representing a bingo game.

  It is a tuple containing the list of called values, as well as a list of
  bingo boards.
  """
  @type game() :: {list(String.t()), list(board())}

  @typedoc """
  The data structure representing bingo boards.

  It is a list of rows.
  """
  @type board() :: list(segment())

  @typedoc """
  The data structure representing any grouping of cells relevent to determining
  a winning board.

  Essentially, it is either a column, or a row.
  """
  @type segment() :: list(cell())

  @typedoc """
  The representation of a cell on a bingo board.

  It contains the string value of the cell, as well as a boolean indicating
  whether it has been marked.
  """
  @type cell :: {String.t(), bool()}

  @doc """
  Given encoded bingo game input, returns the value of the winning board.

  ## Examples

      iex> input = """
      ...> 7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1
      ...>
      ...> 22 13 17 11  0
      ...>  8  2 23  4 24
      ...> 21  9 14 16  7
      ...>  6 10  3 18  5
      ...>  1 12 20 15 19
      ...>
      ...>  3 15  0  2 22
      ...>  9 18 13 17  5
      ...> 19  8  7 25 23
      ...> 20 11 10 24  4
      ...> 14 21 16 12  6
      ...>
      ...> 14 21 17 24  4
      ...> 10 16 15  9 19
      ...> 18  8 23 26 20
      ...> 22 11 13  6  5
      ...>  2  0 12  3  7
      ...> """
      iex> AdventOfCode.DayFour.win(input)
      4512
  """
  def win(input) do
    input
    |> parse_input
    |> build_game
    |> win_game
  end

  @doc """
  Given encoded bingo game input, returns the value of the losing board.

  ## Examples

      iex> input = """
      ...> 7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1
      ...>
      ...> 22 13 17 11  0
      ...>  8  2 23  4 24
      ...> 21  9 14 16  7
      ...>  6 10  3 18  5
      ...>  1 12 20 15 19
      ...>
      ...>  3 15  0  2 22
      ...>  9 18 13 17  5
      ...> 19  8  7 25 23
      ...> 20 11 10 24  4
      ...> 14 21 16 12  6
      ...>
      ...> 14 21 17 24  4
      ...> 10 16 15  9 19
      ...> 18  8 23 26 20
      ...> 22 11 13  6  5
      ...>  2  0 12  3  7
      ...> """
      iex> AdventOfCode.DayFour.lose(input)
      1924
  """
  def lose(input) do
    input
    |> parse_input
    |> build_game
    |> lose_game
  end

  defp parse_input(input) do
    input
    |> String.split("\n\n")
  end

  @spec build_game(list(String.t())) :: game()
  defp build_game([move_string | board_strings]) do
    moves =
      move_string
      |> String.split(",")

    boards =
      board_strings
      |> Enum.map(&build_board/1)

    {moves, boards}
  end

  @spec build_board(String.t()) :: board()
  defp build_board(board_string) do
    board_string
    |> String.split("\n", trim: true)
    |> Enum.map(&build_row/1)
  end

  defp build_row(row_string) do
    row_string
    |> String.split()
    |> Enum.map(&build_cell/1)
  end

  @spec build_cell(String.t()) :: cell()
  defp build_cell(value) do
    {value, false}
  end

  defp win_game({values, boards}) do
    boards
    |> find_winner(values)
    |> board_value
  end

  defp lose_game({values, boards}) do
    boards
    |> find_loser(values)
    |> board_value
  end

  defp board_value({winning_board, final_value}) do
    summed_board =
      winning_board
      |> List.flatten()
      |> Enum.reduce(0, &board_summer/2)

    summed_board * String.to_integer(final_value)
  end

  defp board_summer({value_str, false}, sum) do
    String.to_integer(value_str) + sum
  end

  defp board_summer({_, true}, sum) do
    sum
  end

  defp find_loser(initial_boards, all_values) do
    find_loser(initial_boards, all_values, {[], ""})
  end

  defp find_loser([], _, {[winner], final_value}) do
    {winner, final_value}
  end

  defp find_loser(boards, [current_value | remaining_values], _) do
    updated_boards = Enum.map(boards, &mark_board(&1, current_value))
    potential_winners = Enum.filter(updated_boards, &winning_board?/1)

    find_loser(updated_boards -- potential_winners, remaining_values, {potential_winners, current_value})
  end

  defp find_winner(initial_boards, all_values) do
    find_winner(initial_boards, all_values, {[], ""})
  end

  defp find_winner(_, _, {[winning_board], final_value}) do
    {winning_board, final_value}
  end

  defp find_winner(boards, [current_value | remaining_values], {[], _}) do
    updated_boards = Enum.map(boards, &mark_board(&1, current_value))
    potential_winners = Enum.filter(updated_boards, &winning_board?/1)

    find_winner(updated_boards, remaining_values, {potential_winners, current_value})
  end

  defp winning_board?(rows) do
    rows
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> (fn columns -> rows ++ columns end).()
    |> Enum.map(&winning_segment?/1)
    |> Enum.any?()
  end

  defp winning_segment?(segment) do
    segment |> Enum.all?(&is_marked?/1)
  end

  defp is_marked?({_value, marked?}), do: marked?

  defp mark_board(board, value) do
    board |> Enum.map(&mark_row(&1, value))
  end

  defp mark_row(row, value) do
    row |> Enum.map(&mark_cell(&1, value))
  end

  defp mark_cell({_, true} = cell, _) do
    cell
  end

  defp mark_cell({cell_value, false}, called_value) do
    {cell_value, cell_value == called_value}
  end
end
