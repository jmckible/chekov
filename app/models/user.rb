class User < ActiveRecord::Base

  def self.authenticate(email)
    User.find_by_email email
  end

  has_many :assignments, :dependent=>:destroy
  has_many :checks,      :through=>:suites
  has_many :suites,      :dependent=>:destroy

  scope :abc,    -> { active.order('last_name, first_name') }
  scope :active, -> { where(active: true) }

  def name() "#{first_name} #{last_name}" end

  def assigned?(context, browser)
    assignments.for_context(context).for_browser(browser).count > 0
  end

  validates :email, presence: true, uniqueness: true

end
