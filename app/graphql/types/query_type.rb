# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Congratulations! Your requests are now authorized using App Bridge Authentication."
    end

    # First describe the field signature:
    field :product, ProductType, null: true do
      description "Find a product by ID"
      argument :id, ID, required: true
    end

    # Then provide an implementation:
    def product(id:)
      Product.find_by_id(id)
    end
  end
end
