description = <<-DESCRIPTION
<div>Explore the nature and art oasis at our unique property. The living room, a cozy masterpiece, and the fully equipped kitchen are ideal for cooking and entertaining. Step outside to our garden patio, unwind, and enjoy morning birdsong. Tastefully decorated bedrooms, a powder room, and utility area complete the experience.<br />Note: The property is surrounded by a residential area. Despite initial surroundings, I am sure that, stepping in will fill your mood with joy and happiness.
</div>
<h4 class="font-medium" tabindex="-1">The space</h4>
<p>Escape to a hidden gem in the heart of nature with our beautiful and artistic property. Our spacious and welcoming home is the perfect retreat for those looking to escape the hustle and bustle of the city and reconnect with nature.<br />As you enter through our beautifully adorned main gate with mandala art, you'll immediately feel a sense of peace and positive energy. The gate is an entryway to an amazing experience that is designed to help you unwind and relax.<br />Our living room is a work of art, with fascinating elements that create a cozy and unforgettable ambiance. The room features artistic designs, which are evident in the use of color, the decorations on the wall, and the unique furniture arrangement. The artistic flair adds a unique touch of elegance to the living room, making it the perfect place to spend time with family and friends. Our fully equipped kitchen is a modern open design with bamboo roofing, perfect for cooking and entertaining guests.<br />Step outside and experience the beauty of our garden patio, complete with a lush green view and the calming sounds of chirping birds in the morning. The patio is an extension of the living room, where you can enjoy your meals and relax in the fresh air. Fire up the barbecue in our cozy gazebo for a fun and relaxing evening with friends and family. The garden patio is the perfect place to unwind, read a book or just take a nap under the shade of a tree.<br />The bedrooms are spacious, comfortable, and tastefully decorated, with plenty of natural light, beautiful art pieces and a calming color scheme. The beds are comfortable, and the linens are soft and luxurious, providing you with the best possible sleeping experience.<br />Even our powder room and utility area have been designed with sustainability in mind. The utility area is a cleverly designed space that is efficient and has all the modern amenities required for your stay.<br />Note: The property is surrounded by a residential area. Despite initial surroundings, I am sure that, stepping in will fill your mood with joy and happiness.</p>
<h4 class="font-medium" tabindex="-1">Guest Policy</h4>
<p>Entire Property is yours!! Wish you fun and happy stay!!</p>
DESCRIPTION

pictures = []
20.times do 
  pictures << URI.parse(Faker::LoremFlickr.image).open
end

user = User.find_or_create_by!(email: 'test1@gmail.com') do |u|
  u.password = '123456'
  u.name = Faker::Lorem.unique.sentence(word_count: 3)
  u.address_1 = Faker::Address.street_address
  u.address_2 = Faker::Address.street_name
  u.city = Faker::Address.city
  u.state = Faker::Address.state
  u.country = Faker::Address.country
end

user.reload 

user.picture.attach(io: pictures[0] , filename: user.name)

19.times do |i|
  random_user = User.create!({
    email: "test#{i + 2}@gmail.com",
    password: '123456',
    name: Faker::Lorem.unique.sentence(word_count: 3),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
  })

  random_user.picture.attach(io: pictures[i+1] , filename: user.name)
end

# Total available images
total_images = 16
images_per_property = 5
total_properties = 6

# Create an array of all image numbers shuffled
all_images = (1..total_images).to_a.shuffle

# Track which images we've used to distribute evenly
used_images = []

total_properties.times do |i|
  property = Property.create!({
    name: Faker::Lorem.unique.sentence(word_count: 3),
    headline: Faker::Lorem.unique.sentence(word_count: 6),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    price: Money.from_amount((50..100).to_a.sample, 'USD'),
    bedrooom_count: (2..5).to_a.sample,
    bed_count: (4..10).to_a.sample,
    guest_count: (4..20).to_a.sample,
    bathroom_count: (1..4).to_a.sample,
    description: description
  })


  # Select images for this property
  property_images = if all_images.size >= images_per_property
                     all_images.pop(images_per_property)
                   else
                     # If we run out of unique images, start reusing from the beginning
                     (all_images + (1..total_images).to_a).take(images_per_property)
                   end

  property_images.each do |image_num|
    image_path = "db/images/prop_#{image_num}.png"
    
    if File.exist?(image_path)
      property.images.attach(io: File.open(image_path), filename: "#{property.name}_#{image_num}")
    else
      puts "Image not found: #{image_path}"
    end
  end

  ((5..10).to_a.sample).times do
    Review.create!({
      content: Faker::Lorem.paragraph(sentence_count: 10),
      cleanliness_rating: (1..5).to_a.sample,
      accuracy_rating: (1..5).to_a.sample,
      checkin_rating: (1..5).to_a.sample,
      communication_rating: (1..5).to_a.sample,
      location_rating: (1..5).to_a.sample,
      value_rating: (1..5).to_a.sample,
      property: property,
      user: User.all.sample
    })
  end
end