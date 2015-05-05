Depot.Repo.delete_all(Depot.Product)
product = %Depot.Product{\
  title: "Programming Ruby 1.9 & 2.0", \
  description: "<p>Ruby is the fastest growing and most exciting</p>", \
  image_url: "ruby.jpg", \
  price: Decimal.new("49.95") }
Depot.Repo.insert(product)
