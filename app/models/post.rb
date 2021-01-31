class Post < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :content

  after_initialize :set_default_status

  # Post statuses
  #   deleted
  #   pending = pending review
  #   published = visible for everyone
  #   restricted = visible for users with subscriber role and above
  enum status: [:deleted, :pending, :published, :restricted, :revise]

  belongs_to :user, optional: true



  private

  def set_default_status
    self.status ||= :pending
  end
end
