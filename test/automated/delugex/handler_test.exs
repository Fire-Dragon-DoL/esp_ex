defmodule Delugex.HandlerTest do
  use ExUnit.Case, async: true

  alias Delugex.Event.Raw
  alias Delugex.StreamName

  @stream_name %StreamName{category: "campaign", identifier: "123", types: []}
  @raw %Event.Raw{
    id: "11111111",
    stream_name: @stream_name,
    type: "Updated",
    data: %{name: "Unnamed"}
  }

  defmodule Nopped do
    defstruct []
  end

  defmodule Renamed do
    defstruct []
  end

  defmodule PersonHandler do
    use Delugex.Handler

    @impl Delugex.Handler
    def handle(%Renamed{}, _, _) do
      send(self(), {:renamed})
    end
  end

  describe "Handler.handle" do
    test "defaults to doing nothing" do
      PersonHandler.handle(%Nopped{}, @raw, nil)
    end

    test "calls specific handle when implemented" do
      PersonHandler.handle(%Renamed{}, @raw, nil)

      assert_receive({:renamed})
    end
  end
end
