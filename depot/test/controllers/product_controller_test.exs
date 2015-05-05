defmodule Depot.ProductControllerTest do
  use Depot.ConnCase

  alias Depot.Product
  @valid_params product: %{description: "some content", image_url: "some_image.jpg", price: "120.5", title: "some content"}
  @invalid_params product: %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "GET /products", %{conn: conn} do
    conn = get conn, product_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing products"
  end

  test "GET /products/new", %{conn: conn} do
    conn = get conn, product_path(conn, :new)
    assert html_response(conn, 200) =~ "New product"
  end

  test "POST /products with valid data", %{conn: conn} do
    conn = post conn, product_path(conn, :create), @valid_params
    assert redirected_to(conn) == product_path(conn, :index)
  end

  test "POST /products with invalid data", %{conn: conn} do
    conn = post conn, product_path(conn, :create), @invalid_params
    assert html_response(conn, 200) =~ "New product"
  end

  test "GET /products/:id", %{conn: conn} do
    product = Repo.insert %Product{}
    conn = get conn, product_path(conn, :show, product)
    assert html_response(conn, 200) =~ "Show product"
  end

  test "GET /products/:id/edit", %{conn: conn} do
    product = Repo.insert %Product{}
    conn = get conn, product_path(conn, :edit, product)
    assert html_response(conn, 200) =~ "Edit product"
  end

  test "PUT /products/:id with valid data", %{conn: conn} do
    product = Repo.insert %Product{}
    conn = put conn, product_path(conn, :update, product), @valid_params
    assert redirected_to(conn) == product_path(conn, :index)
  end

  test "PUT /products/:id with invalid data", %{conn: conn} do
    product = Repo.insert %Product{}
    conn = put conn, product_path(conn, :update, product), @invalid_params
    assert html_response(conn, 200) =~ "Edit product"
  end

  test "DELETE /products/:id", %{conn: conn} do
    product = Repo.insert %Product{}
    conn = delete conn, product_path(conn, :delete, product)
    assert redirected_to(conn) == product_path(conn, :index)
    refute Repo.get(Product, product.id)
  end
end
