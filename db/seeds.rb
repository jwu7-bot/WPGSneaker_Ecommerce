require "csv"
require "open-uri"
require "json"

Product.delete_all
Category.delete_all
Page.delete_all

# Categories with products
categories_with_products = {
  "Sneakers" => [
    { name: "Nike Air Force 1", price: 15000, stock_quantity: 20, description: "Classic white leather sneakers with a comfortable sole and iconic design." },
    { name: "Adidas Ultraboost 21", price: 25000, stock_quantity: 20, description: "High-performance running sneakers with responsive cushioning and a sleek design." },
    { name: "Converse Chuck Taylor All Star", price: 7500, stock_quantity: 20, description: "Timeless canvas sneakers with rubber toe cap and signature style." },
    { name: "New Balance 574", price: 12000, stock_quantity: 20, description: "Retro-inspired sneakers with a mix of suede and mesh materials for everyday comfort." },
    { name: "Puma RS-X3", price: 14000, stock_quantity: 20, description: "Bold and chunky sneakers with a playful, colorful design and cushioned sole." }
  ],
  "T-Shirts" => [
    { name: "Hanes Basic Tee", price: 1200, stock_quantity: 20, description: "Soft cotton T-shirt with a classic fit and crew neck, perfect for everyday wear." },
    { name: "Nike Dri-FIT Tee", price: 3500, stock_quantity: 20, description: "Lightweight T-shirt with moisture-wicking technology, ideal for sports and exercise." },
    { name: "Adidas Originals Trefoil Tee", price: 4000, stock_quantity: 20, description: "Comfortable cotton T-shirt with the iconic Trefoil logo on the chest." },
    { name: "Uniqlo U Crew Neck T-Shirt", price: 1800, stock_quantity: 20, description: "Minimalist T-shirt made with durable cotton, offering a clean and modern look." },
    { name: "Supreme Box Logo Tee", price: 11000, stock_quantity: 20, description: "Popular streetwear T-shirt with the iconic box logo, known for its simple yet bold design." }
  ],
  "Hoodies" => [
    { name: "Champion Reverse Weave Hoodie", price: 8000, stock_quantity: 20, description: "Heavyweight cotton hoodie with a classic fit and durable construction." },
    { name: "Nike Sportswear Club Fleece Hoodie", price: 7000, stock_quantity: 20, description: "Soft fleece hoodie with a standard fit, perfect for casual wear." },
    { name: "Adidas Essentials 3-Stripes Hoodie", price: 6500, stock_quantity: 20, description: "Comfortable hoodie with the classic 3-Stripes along the sleeves and a kangaroo pocket." },
    { name: "Carhartt WIP Hooded Chase Sweat", price: 11000, stock_quantity: 20, description: "Thick, warm hoodie with embroidered Carhartt logo, designed for durability and comfort." },
    { name: "Patagonia Better Sweater Fleece Hoodie", price: 15000, stock_quantity: 20, description: "Eco-friendly hoodie made with recycled materials, providing warmth and style." }
  ],
  "Pants" => [
    { name: "Levi's 501 Original Fit Jeans", price: 8000, stock_quantity: 20, description: "Iconic straight-leg jeans with a classic fit, made from durable denim." },
    { name: "Nike Sportswear Tech Fleece Pants", price: 10000, stock_quantity: 20, description: "Lightweight, warm fleece pants with a modern slim fit and zippered pockets." },
    { name: "Adidas Essentials 3-Stripes Pants", price: 6000, stock_quantity: 20, description: "Comfortable athletic pants with a tapered fit and signature 3-Stripes on the sides." },
    { name: "Carhartt Rugged Flex Rigby Dungaree", price: 7500, stock_quantity: 20, description: "Workwear-inspired pants with added flexibility for mobility and comfort." },
    { name: "Lululemon ABC Pant Slim", price: 14000, stock_quantity: 20, description: "High-quality slim-fit pants designed with stretch fabric, ideal for both work and casual wear." }
  ]
}
# Loop through each category
categories_with_products.each do |category_name, products|
  # Create or find the category
  category = Category.find_or_create_by(name: category_name)

  # Create each product from each categorys
  products.each do |product_data|
    Product.create(
      name: product_data[:name],
      price: product_data[:price],
      stock_quantity: product_data[:stock_quantity],
      description: product_data[:description],
      category: category
    )
  end
end

# CSV file
filename = Rails.root.join("db/nike_shoes.csv")
puts "Loading data from this file: #{filename}"

# Read CSV data
csv_data = File.read(filename)
products = CSV.parse(csv_data, headers: true, encoding: "utf-8")

# Loop through each product in CSV
products.take(80).each do |product|
  # Create or find the category
  category = Category.find_or_create_by(name: "Sneakers")

  # Create the product
  p = Product.create!(
    name: product["product_name"],
    price: product["sale_price"],
    stock_quantity: 20,
    description: product["description"],
    category: category
  )

  # Attach only the first image
  if product["images"].present?
    begin
      # Parse the JSON string to get the array of URLs
      image_urls = JSON.parse(product["images"].gsub('""', '"')) # Fixes the escaped double quotes

      # Get the first image URL
      first_image_url = image_urls.first

      # Validate the URL
      if first_image_url.present?
        file = URI.open(first_image_url)
        p.image.attach(io: file, filename: File.basename(URI.parse(first_image_url).path))
        puts "Successfully attached image to product #{p.name}"
      else
        puts "No valid URL found for product #{p.name}"
      end

    rescue OpenURI::HTTPError => e
      puts "Failed to download image #{first_image_url} for product #{p.name}: #{e.message}"
    rescue JSON::ParserError => e
      puts "Failed to parse image URLs for product #{p.name}: #{e.message}"
    rescue => e
      puts "An unexpected error occurred for product #{p.name}: #{e.message}"
    end
  else
    puts "No images provided for product #{p.name}"
  end
end

Page.create(
  title: "About Us",
  content: "Welcome to WPGSnearker! Your go-to destination for premium footwear and clothing!",
  permalink: "about_us")

Page.create(
  title: "Contact Us",
  content: "Conta me at jwu7@rrc.ca",
  permalink: "contact_us"
)


puts "There are #{Category.count} Categories."
puts "There are #{Product.count} Products."
puts "There are #{Page.count} Pages."

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end
