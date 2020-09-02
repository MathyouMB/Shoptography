# GraphQL-Batch Loader for Entity Relations
class Loaders::RecordLoader < GraphQL::Batch::Loader
  def initialize(model, column: model.primary_key)
    @model = model
    @column = column.to_s
    @column_type = model.type_for_attribute(@column)
  end

  def load(key)
    super(@column_type.cast(key))
  end

  def perform(keys)
    query(keys).each do |record|
      value = @column_type.cast(record.public_send(@column))
      fulfill(value, record)
    end
    keys.each { |key| fulfill(key, nil) unless fulfilled?(key) }
  end

  private

  def query(keys)
    scope = @model
    scope.where(@column => keys)
  end
end
