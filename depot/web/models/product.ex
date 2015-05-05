defmodule Depot.Product do
  use Depot.Web, :model
  require Logger

  schema "products" do
    field :title, :string
    field :description, :string
    field :image_url, :string
    field :price, :decimal

    timestamps
  end

  @required_fields ~w(title description image_url price)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_decimal(:price, greater_than_or_equal_to: 0.01)
    |> validate_unique(:title, on: Depot.Repo)
    |> validate_format(:image_url, ~r/\.(gif|jpg|png)\Z/i, message: "must be a URL for GIF, JPG or PNG image")
  end

  @decimal_validators %{
    less_than: { [-1], "must be less than " },
    greater_than: { [1], "must be greater than " },
    less_than_or_equal_to: { [-1, 0], "must be less than or equal to " },
    greater_than_or_equal_to: { [0, 1], "must be greater than or equal to " },
    equal_to: { [0], "must be equal to " }
  }

  def validate_decimal(changeset, field, opts) do
    validate_change(changeset, field, {:decimal, opts}, fn
      field, value ->
        Enum.find_value opts, [], fn {spec_key, target_value} ->
          validate_decimal(field, value, opts, spec_key, target_value)
        end
    end)
  end

  defp validate_decimal(field, value, opts, spec_key, target_value) do
    target_value = Decimal.new(target_value)
    case Map.fetch(@decimal_validators, spec_key) do
      {:ok, {spec_values, error_message}} ->
        res = Decimal.compare(value, Decimal.new(target_value))
        case Enum.any?(spec_values, fn(x) -> Decimal.new(x) == res end) do
          true -> nil
          false -> [{field, message(opts, error_message) <> Decimal.to_string(target_value)}]
        end
      _ -> nil
    end
  end

  defp message(opts, default) do
    Keyword.get(opts, :message, default)
  end
end
