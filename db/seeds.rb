# db/seeds.rb
Product.create([
  { name: 'Producto 1', price: 1000 },
  { name: 'Producto 2', price: 2000, },
  { name: 'Producto 3', price: 3000,}
])

User.create(email: 'user@example.com', password: 'password123')
