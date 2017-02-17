defmodule ElhexDelivery.PostalCode.NavigatorTest do
  use ExUnit.Case
  alias ElhexDelivery.PostalCode.Navigator
  doctest ElhexDelivery

  describe "get_distance" do
    # test "postal code strings" do
    #   distance = Navigator.get_distance("94062", "94101")
    #   assert is_float(distance)
    # end

    # test "postal code integers" do
    #   distance = Navigator.get_distance(94062, 94101)
    #   assert is_float(distance)
    # end

    # test "postal code mixed" do
    #   distance = Navigator.get_distance(94062, "94101")
    #   assert is_float(distance)
    # end

    @tag :capture_log
    test "postal code with unexpected format" do
      nav_pid = Process.whereis(:postal_code_navigator)
      ref = Process.monitor(nav_pid)

      catch_exit do
        Navigator.get_distance("94062", 94062.01)
      end

      assert_received({:DOWN, ^ref, :process, ^nav_pid, {%ArgumentError{}, _}})
    end

    test "actual postal codes" do
      # New York to SF

      distance = Navigator.get_distance(94104, 10112)
      assert distance == 2565.28
    end
  end
end
