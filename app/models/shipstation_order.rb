# frozen_string_literal: true

class ShipstationOrder < ApplicationRecord
  has_many :items
end
