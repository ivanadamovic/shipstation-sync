# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :shipstation_order
end
