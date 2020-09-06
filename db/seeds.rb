# Users
user = User.create(
  first_name: 'Matthew',
  last_name: 'MacRae-Bovell',
  email: 'matt@email.com',
  password: '1234',
  balance: 10000.00,
)

user2 = User.create(
  first_name: 'John',
  last_name: 'Smith',
  email: 'john.smith@email.com',
  password: '1234',
  balance: 10000.00,
)

# Images
image1 = Image.create(
  title: 'Winter',
  description: 'Snowy winter stock image.',
  user_id: user.id,
  price: 9.99,
  private: false
)

image1.attached_image.attach(io: File.open('assets/1.jpeg'), filename: '1.jpeg')

image2 = Image.create(
  title: 'Moose',
  description: 'A moose eating grass.',
  user_id: user2.id,
  price: 7.99,
  private: false
)

image2.attached_image.attach(io: File.open('assets/2.jpg'), filename: '2.jpg')

image3 = Image.create(
  title: 'Water Fall',
  description: 'Picture of a waterfall with a few trees.',
  user_id: user.id,
  price: 8.99,
  private: false
)

image3.attached_image.attach(io: File.open('assets/3.jpeg'), filename: '3.jpeg')

image4 = Image.create(
  title: 'Mountain',
  description: 'A field with a mountain in the distance.',
  user_id: user2.id,
  price: 2.99,
  private: false
)

image4.attached_image.attach(io: File.open('assets/4.jpeg'), filename: '4.jpeg')

image5 = Image.create(
  title: 'Sunrise',
  description: 'A Silhouette watching an orangy pink sunrise.',
  user_id: user.id,
  price: 4.99,
  private: false
)

image5.attached_image.attach(io: File.open('assets/5.jpeg'), filename: '5.jpeg')

image6 = Image.create(
  title: 'Flowers',
  description: 'A girl in a pink dress picks blue flowers.',
  user_id: user2.id,
  price: 4.99,
  private: false
)

image6.attached_image.attach(io: File.open('assets/6.jpg'), filename: '6.jpg')

image7 = Image.create(
  title: 'Forest',
  description: 'Forest image from a top down perspective.',
  user_id: user.id,
  price: 2.99,
  private: false
)

image7.attached_image.attach(io: File.open('assets/7.jpeg'), filename: '7.jpeg')

image8 = Image.create(
  title: 'Pine Tree',
  description: 'An image of a pine tree.',
  user_id: user2.id,
  price: 1.99,
  private: false
)

image8.attached_image.attach(io: File.open('assets/8.jpeg'), filename: '8.jpeg')

image9 = Image.create(
  title: 'Pigeon',
  description: 'An image of a pigeon.',
  user_id: user.id,
  price: 11.99,
  private: false
)

image9.attached_image.attach(io: File.open('assets/9.png'), filename: '9.png')

image10 = Image.create(
  title: 'Blue Jay',
  description: 'An image of a Blue Jay.',
  user_id: user2.id,
  price: 6.99,
  private: true
)

image10.attached_image.attach(io: File.open('assets/10.jpg'), filename: '10.jpg')

# Tags

tag_nature = Tag.create(
  name: 'Nature'
)

tag_winter = Tag.create(
  name: 'Winter'
)

tag_snow = Tag.create(
  name: 'Snow'
)

tag_tree = Tag.create(
  name: 'Tree'
)

tag_wood = Tag.create(
  name: 'Wood'
)

tag_animal = Tag.create(
  name: 'Animal'
)

tag_water = Tag.create(
  name: 'Water'
)

tag_green = Tag.create(
  name: 'Green'
)

tag_mountain = Tag.create(
  name: 'Mountain'
)

tag_sky = Tag.create(
  name: 'Sky'
)

tag_human = Tag.create(
  name: 'Human'
)

tag_cloud = Tag.create(
  name: 'Cloud'
)

tag_forest = Tag.create(
  name: 'Forest'
)

tag_dress = Tag.create(
  name: 'Dress'
)

tag_pink = Tag.create(
  name: 'Pink'
)

tag_blue = Tag.create(
  name: 'Blue'
)

tag_flower = Tag.create(
  name: 'Flower'
)

tag_top_down = Tag.create(
  name: 'Top Down'
)

tag_bird = Tag.create(
  name: 'Bird'
)

# Image Tags
ImageTag.create(
  image_id: image1.id,
  tag_id: tag_nature.id
)

ImageTag.create(
  image_id: image1.id,
  tag_id: tag_winter.id
)

ImageTag.create(
  image_id: image1.id,
  tag_id: tag_snow.id
)

ImageTag.create(
  image_id: image1.id,
  tag_id: tag_tree.id
)

ImageTag.create(
  image_id: image1.id,
  tag_id: tag_forest.id
)

ImageTag.create(
  image_id: image1.id,
  tag_id: tag_cloud.id
)

ImageTag.create(
  image_id: image2.id,
  tag_id: tag_animal.id
)

ImageTag.create(
  image_id: image2.id,
  tag_id: tag_forest.id
)

ImageTag.create(
  image_id: image2.id,
  tag_id: tag_wood.id
)

ImageTag.create(
  image_id: image3.id,
  tag_id: tag_water.id
)

ImageTag.create(
  image_id: image3.id,
  tag_id: tag_wood.id
)

ImageTag.create(
  image_id: image4.id,
  tag_id: tag_sky.id
)

ImageTag.create(
  image_id: image4.id,
  tag_id: tag_mountain.id
)

ImageTag.create(
  image_id: image4.id,
  tag_id: tag_blue.id
)

ImageTag.create(
  image_id: image5.id,
  tag_id: tag_human.id
)

ImageTag.create(
  image_id: image5.id,
  tag_id: tag_sky.id
)

ImageTag.create(
  image_id: image5.id,
  tag_id: tag_pink.id
)

ImageTag.create(
  image_id: image5.id,
  tag_id: tag_blue.id
)

ImageTag.create(
  image_id: image6.id,
  tag_id: tag_human.id
)

ImageTag.create(
  image_id: image6.id,
  tag_id: tag_sky.id
)

ImageTag.create(
  image_id: image6.id,
  tag_id: tag_dress.id
)

ImageTag.create(
  image_id: image6.id,
  tag_id: tag_pink.id
)

ImageTag.create(
  image_id: image6.id,
  tag_id: tag_blue.id
)

ImageTag.create(
  image_id: image6.id,
  tag_id: tag_forest.id
)

ImageTag.create(
  image_id: image6.id,
  tag_id: tag_flower.id
)

ImageTag.create(
  image_id: image7.id,
  tag_id: tag_forest.id
)

ImageTag.create(
  image_id: image7.id,
  tag_id: tag_green.id
)

ImageTag.create(
  image_id: image7.id,
  tag_id: tag_top_down.id
)

ImageTag.create(
  image_id: image7.id,
  tag_id: tag_wood.id
)

ImageTag.create(
  image_id: image8.id,
  tag_id: tag_wood.id
)

ImageTag.create(
  image_id: image8.id,
  tag_id: tag_tree.id
)

ImageTag.create(
  image_id: image8.id,
  tag_id: tag_nature.id
)

ImageTag.create(
  image_id: image8.id,
  tag_id: tag_forest.id
)

ImageTag.create(
  image_id: image9.id,
  tag_id: tag_bird.id
)

ImageTag.create(
  image_id: image9.id,
  tag_id: tag_animal.id
)

ImageTag.create(
  image_id: image10.id,
  tag_id: tag_bird.id
)

ImageTag.create(
  image_id: image10.id,
  tag_id: tag_animal.id
)

ImageTag.create(
  image_id: image10.id,
  tag_id: tag_blue.id
)

purchase = Purchase.create(
  title: image9.title,
  description: image9.description,
  user_id: user2.id,
  merchant_id: image9.user.id,
  cost: image9.price
)

purchase.attached_image.attach(io: File.open('assets/9.png'), filename: '9.png')

purchase2 = Purchase.create(
  title: image8.title,
  description: image8.description,
  user_id: user.id,
  merchant_id: image8.user.id,
  cost: image8.price
)

purchase2.attached_image.attach(io: File.open('assets/8.jpeg'), filename: '8.jpeg')
