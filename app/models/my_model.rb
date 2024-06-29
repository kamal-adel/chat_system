# app/models/my_model.rb
class MyModel < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
  
    # Your model code
  end
  