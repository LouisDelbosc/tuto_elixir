defmodule GameOfLife.CellTest do
  use ExUnit.Case, async: true

  test "alive cell with no neighbours dies" do
    alive_cell = {1, 1}
    alive_cells = MapSet.new([alive_cell])
    refute GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  test "alive cell with 1 neighbour dies" do
    alive_cell = {1, 1}
    alive_cells = MapSet.new([alive_cell, {0, 0}])
    refute GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  test "alive cell with more than 3 neighbours dies" do
    alive_cell = {1, 1}
    alive_cells = MapSet.new([alive_cell, {0, 0}, {1, 0}, {2, 0}, {2, 1}])
    refute GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  test "alive cell with 2 neighbours lives" do
    alive_cell = {1, 1}
    alive_cells = MapSet.new([alive_cell, {0, 0}, {1, 0}])
    assert GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  test "alive cell with 3 neighbours lives" do
    alive_cell = {1, 1}
    alive_cells = MapSet.new([alive_cell, {0, 0}, {1, 0}, {2, 1}])
    assert GameOfLife.Cell.keep_alive?(alive_cells, alive_cell)
  end

  test "dead cell with three live neighbours becomes a live cell" do
    alive_cells = MapSet.new([{2, 2}, {1, 0}, {2, 1}])
    dead_cell = {1, 1}
    assert GameOfLife.Cell.become_alive?(alive_cells, dead_cell)
  end

  test "dead cell with three live neighbours stay dead" do
    alive_cells = MapSet.new([{2, 2}, {1, 0}])
    dead_cell = {1, 1}
    refute GameOfLife.Cell.become_alive?(alive_cells, dead_cell)
  end

  test "find dead cells (neighbours of alive cell)" do
    alive_cells = MapSet.new([{1, 1}])
    dead_neighbours = GameOfLife.Cell.dead_neighbours(alive_cells)
    expected_dead_neighbours = MapSet.new([
      {0, 0}, {1, 0}, {2, 0},
      {0, 1}, {2, 1},
      {0, 2}, {1, 2}, {2, 2}
    ])
    assert MapSet.equal?(dead_neighbours, expected_dead_neighbours)
  end

  test "find dead cells (neighbours of alive cells)" do
    alive_cells = MapSet.new([{1, 1}, {2, 1}])
    dead_neighbours = GameOfLife.Cell.dead_neighbours(alive_cells)
    expected_dead_neighbours = MapSet.new([
      {0, 0}, {1, 0}, {2, 0}, {3, 0},
      {0, 1}, {3, 1},
      {0, 2}, {1, 2}, {2, 2}, {3, 2}
    ])
    assert MapSet.equal?(dead_neighbours, expected_dead_neighbours)
  end

end
