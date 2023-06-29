class UserBlueprint < Blueprinter::Base
  identifier :uuid
  fields :id, :name, :email, :created_at, :updated_at
end
