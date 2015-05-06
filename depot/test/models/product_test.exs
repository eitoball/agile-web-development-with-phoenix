defmodule Depot.ProductTest do
  use Depot.ModelCase

  alias Depot.Product

  @valid_attrs %{description: "some content", image_url: "some_image.jpg", price: "120.5", title: "some content"}
  @invalid_attrs %{}

  setup do
    product = Repo.insert %Product{title: "Programming Ruby 1.9",
      description: "Ruby is the",
      price: Decimal.new(49.50),
      image_url: "ruby.png"
    }
    {:ok, %{products: %{ruby: product}}}
  end

  test "changeset with valid attributes" do
    changeset = Product.changeset(%Product{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Product.changeset(%Product{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "product attributes must not be empty" do
    changeset = Product.changeset(%Product{}, %{})
    refute changeset.valid?
    assert Dict.has_key?(changeset.errors, :title)
    assert Dict.has_key?(changeset.errors, :description)
    assert Dict.has_key?(changeset.errors, :price)
    assert Dict.has_key?(changeset.errors, :image_url)
  end

  test "product price must be positive" do
    product = %Product{title: "My Book Title", description: "yyy", image_url: "zzz.jpg"}
    changeset = Product.changeset(product, %{price: -1})
    refute changeset.valid?
    assert changeset.errors[:price] == "must be greater than or equal to 0.01"

    changeset = Product.changeset(product, %{price: 0})
    refute changeset.valid?
    assert changeset.errors[:price] == "must be greater than or equal to 0.01"

    changeset = Product.changeset(product, %{price: 1})
    assert changeset.valid?
  end

  defp new_product(image_url) do
    Product.changeset(%Product{
      title: "My Book Title",
      description: "yyy",
      price: 1}, %{image_url: image_url})
  end

  test "image url" do
    ok = ~w(fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif)
    bad = ~w(fred.doc fred.gif/more fred.gif.more)
    Enum.each(ok, fn (name) ->
      assert new_product(name).valid?, name <> " should be valid"
    end)
    Enum.each(bad, fn (name) ->
      refute new_product(name).valid?, name <> " shouldn't be valid"
    end)
  end

  test "product is not valid without a unique title", %{products: products} do
    {:ok, product} = Map.fetch(products, :ruby)
    changeset = Product.changeset(%Product{}, %{
      title: product.title,
      description: "yyy",
      price: Decimal.new(1),
      image_url: "fred.gif"
    })
    refute changeset.valid?
    assert changeset.errors[:title] == "has already been taken"
  end
end
