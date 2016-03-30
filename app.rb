require 'bundler'
Bundler.require

configure do
  enable :cross_origin
end

class Docs
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'EveOnline CREST API in Swagger format'
      key :description, 'EveOnline CREST API in Swagger format'
    end
    key :schemes, ['https']
    key :host, 'public-crest.eveonline.com'
    key :basePath, '/'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  swagger_path '/alliances/' do
    operation :get do
      key :description, 'Get Alliances'
      response 200 do
        key :description, 'Alliances list'
      end
    end
  end

  swagger_path '/alliances/{alliance_id}/' do
    operation :get do
      key :description, 'Get Alliance'
      parameter do
        key :name, 'alliance_id'
        key :in, :path
        key :description, 'Alliance ID'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'Alliance response'
      end
    end
  end
end

# A list of all classes that have swagger_* declarations.
SWAGGERED_CLASSES = [
  Docs,
  self
].freeze

get '/' do
  send_file './public/index.html'
end

get '/doc' do
  content_type :json

  Swagger::Blocks.build_root_json(SWAGGERED_CLASSES).to_json
end
