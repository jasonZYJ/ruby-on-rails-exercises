class Order < ActiveRecord::Base
  validates :customer_name, :customer_email, :description, :price, :frame_id, presence: true
  validate :completion_date_must_be_in_past

  scope :paid,   -> { where("paid_for_on is not null") }
  scope :unpaid, -> { where("paid_for_on is null") }
  
  scope :finished,   -> { where("completed_on is not null") }
  scope :unfinished, -> { where("completed_on is null") }
  
  belongs_to :frame
  has_one :brand, through: :frame

  def brand_id
    brand ? brand.id : nil
  end

  private

  def completion_date_must_be_in_past
    errors.add(:completed_on, "Can't be in the future") if completed_on && completed_on > Time.now
  end

end
