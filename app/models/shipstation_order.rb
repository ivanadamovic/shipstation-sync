# frozen_string_literal: true

class ShipstationOrder < ApplicationRecord
  has_many :items, dependent: :destroy

  default_scope { order(created_at: :desc) }
end
