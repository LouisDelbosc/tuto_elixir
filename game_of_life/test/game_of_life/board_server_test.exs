defmodule GameOfLife.BoardServerTest do
  use ExUnit.Case
  doctest GameOfLife.BoardServer

  test "Check if basic server calls works" do
    first_return = MapSet.new([{0, 0}])
    second_return = MapSet.new([{0, 0}, {0, 1}])
    final_state = {MapSet.new([{0, 0}, {0, 1}]), 0}
    assert MapSet.equal? first_return, GameOfLife.BoardServer.set_alive_cells([{0, 0}])
    assert MapSet.equal? second_return, GameOfLife.BoardServer.add_cells([{0, 1}])
    assert MapSet.equal? second_return, GameOfLife.BoardServer.alive_cells()
    assert final_state == GameOfLife.BoardServer.state
  end

  test "stuff here" do
    assert 0 == GameOfLife.BoardServer.generation_counter
    assert :ok == IO.inspect GameOfLife.BoardServer.tick
    assert 1 == GameOfLife.BoardServer.generation_counter
    assert {MapSet.new([]), 1} == GameOfLife.BoardServer.state
  end

end
