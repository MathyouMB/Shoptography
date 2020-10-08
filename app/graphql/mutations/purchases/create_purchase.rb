module Mutations
  module Purchases
    # Mutation that creates an Purchase entity with the provided Image
    class CreatePurchase < BaseMutation
      argument :image_id, ID, required: true

      type String

      def resolve(image_id:)
        user = context[:current_user]
        return GraphQL::ExecutionError.new('ERROR: Not logged in or missing token') if user.nil?

        image = Image.find(image_id)
        return GraphQL::ExecutionError.new('ERROR: Requested Image does not exist') if image.nil? || image.private
        return GraphQL::ExecutionError.new('ERROR: User cannot purchase their own Image') if user == image.user
        return GraphQL::ExecutionError.new('ERROR: User cannot afford this purchase') if user.balance < image.price

        ActiveRecord::Base.transaction do
          purchase = ::Purchase.create!(
            title: image.title,
            description: image.description,
            user_id: user.id,
            merchant_id: image.user.id,
            cost: image.price
          )

          purchase.attached_image.attach(image.attached_image.attachment.blob)
          purchase.save

          user.update!(balance: user.balance - image.price)
          image.user.update!(balance: image.user.balance + image.price)
        end

        'Succesfully purchased image.'

      rescue ActiveRecord::RecordInvalid
        GraphQL::ExecutionError.new('ERROR: Invalid operation. Transaction was not successfully completed')
      end
    end
  end
end
