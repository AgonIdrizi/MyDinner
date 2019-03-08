class Item < ApplicationRecord
  monetize :price_cents
  has_one_attached :image
  has_many :line_items
  enum item_category_type: [:starters,:seafood,:salads,:local_food,:fast_food,:beverages,:deserts]
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0.00, less_than: 1000000.00 }
  validates :item_category_type, presence: true, numericality: { greater_than_or_equal: 0, less_than: 10 }
  validates :category, presence: true
  validate :image_validation

  scope :category_starters, -> {where(category: 'starters')}
  scope :category_seafood, -> {where(category: 'seafood')}
  scope :category_salads, -> {where(category: 'salads')}
  scope :category_local_food, -> {where(category: 'local_food')}
  scope :category_fast_food, -> {where(category: 'fast_food')}
  scope :category_beverages, -> {where(category: 'beverages')}
  scope :category_deserts, -> {where(category: 'deserts')}

  #as of now Feb2019 we dont have out of the box image validation with active storage
  def image_validation
    if image.attached?
      if !image.blob.content_type.in?(%w(image/jpeg image/jpg image/png))
        image.purge_later
        errors.add(:image, 'The image wrong format')
      elsif image.blob.content_type.in?(%w(image/jpeg image/jpg image/png)) && image.blob.byte_size > (5 * 1024 * 1024) # Limit size 5MB
        image.purge_later
        errors.add(:image, 'The image oversize limited (5MB)')
      end
    elsif image.attached? == false
      image.purge_later
      errors.add(:image, 'The image required.')
    end
  end
end
