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

  state_machine :state, initial: :new do
    state :new
    state :paid
    state :completed
    
    event :pay do
      transition :new => :paid
    end
    
    event :complete do
      transition :paid => :completed
    end
    
    after_transition any => :paid do |order|
      order.paid_for_on = Time.now
      order.save!
    end
    
    after_transition any => :completed do |order|
      order.completed_on = Time.now
      order.save!
    end
  end


  private

  def completion_date_must_be_in_past
    errors.add(:completed_on, "Can't be in the future") if completed_on && completed_on > Time.now
  end

end
