defmodule GameOfLife.Cell do
  def keep_alive?(alive_cells, {x, y} = _alive_cell) do
    case count_neighbours(alive_cells,{x, y}) do
      2 -> true
      3 -> true
      _ -> false
    end
  end

  def become_alive?(alive_cells, {x, y} = _dead_cell) do
    3 == count_neighbours(alive_cells, {x, y})
  end

  defp count_neighbours(grid, {x, y}) do
    offsets = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1},
               {0, 1}, {1, -1}, {1, 0}, {1, 1}]
    Enum.reduce(offsets, 0, fn({x_off, y_off}, acc) ->
      acc + if Set.member?(grid, {x + x_off, y + y_off}), do: 1, else: 0
    end)
  end

  def dead_neighbours(alive_cells) do
    neighbours = neighbours(alive_cells)
    MapSet.difference(neighbours, alive_cells)
  end

  defp neighbours(cells) do
    offsets = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1},
               {0, 1}, {1, -1}, {1, 0}, {1, 1}]
    Enum.reduce(cells, MapSet.new, fn({x, y}, grid) ->
      Enum.reduce(offsets, grid, fn({x_off, y_off}, grid2) ->
        Set.put(grid2, {x + x_off, y + y_off})
      end)
    end)
  end

end

