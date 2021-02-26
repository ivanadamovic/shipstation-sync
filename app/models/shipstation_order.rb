# frozen_string_literal: true

class ShipstationOrder < ApplicationRecord
  has_many :items

  default_scope { order(created_at: :desc) }
end
