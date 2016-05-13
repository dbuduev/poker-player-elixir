defmodule LeanpokerElixir.Player do
  @version "0.0.1"
  def bet_request(game_state) do
    game_state["current_buy_in"]
  end

  def showdown(game_state) do
    "ok"
  end

  def version, do: @version
end
