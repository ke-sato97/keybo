# frozen_string_literal: true

class Keyboard < ApplicationRecord
  has_many :diagnoses, dependent: :destroy
  has_many :users, dependent: :destroy, through: :diagnoses
  has_many :keyboard_tags, dependent: :destroy
  has_many :tags, dependent: :destroy, through: :keyboard_tags
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true
  validates :os, presence: true
  validates :caption, presence: true
  validates :connect, presence: true

  def self.bookmark_ranks
    Keyboard.find(Bookmark.group(:keyboard_id).order('count(keyboard_id) desc').limit(20).pluck(:keyboard_id))
  end

  def self.comment_ranks
    Keyboard.find(Comment.group(:keyboard_id).order('count(keyboard_id) desc').limit(20).pluck(:keyboard_id))
  end

  def self.diagnosis_ranks
    Keyboard.find(Diagnosis.group(:keyboard_id).order('count(keyboard_id) desc').limit(20).pluck(:keyboard_id))
  end

  def self.all_medium_image_urls
    pluck(:medium_image_urls).flatten.uniq
  end

  def self.all_os
    pluck(:os).flatten.uniq
  end

  def self.all_connect
    pluck(:connect).flatten.uniq
  end

  def self.ransackable_attributes(auth_object = nil)
    ["brand", "caption", "connect", "created_at", "id", "layout", "medium_image_urls", "name", "os", "price", "size", "switch", "updated_at", "url"]
  end
end
