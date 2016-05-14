defmodule LeanpokerElixir.Player do
  @version "0.0.3"
  def bet_request(game_state) do
    %{
      "in_action" => in_action,
      "dealer" => dealer,
      "players" => players,
      "current_buy_in" => current_buy_in,
    } = game_state
    if rem(dealer, length players) == in_action or rem(dealer + 1, length players) == in_action do
      current_buy_in
    else
      0
    end
  end

  def showdown(game_state) do
    "ok"
  end

  def version, do: @version
end
