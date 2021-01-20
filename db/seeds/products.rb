# products
[
  { title: "Product 1", truncated_preview: "Nice!" },
  { title: "Product 2", truncated_preview: "Great!" },
].each { |product| 
  Product.create(product) 
}