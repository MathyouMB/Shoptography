# The GraphQL Schema
class ImageRepositorySchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
  use(GraphQL::Batch)
end
