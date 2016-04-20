require 'bundler'
Bundler.require

configure do
  enable :cross_origin
end

class Docs
  include Swagger::Blocks

  swagger_schema :OutputConstellationsList do
    key :required, [:totalCount_str, :items, :pageCount, :pageCount_str, :totalCount]
    property :totalCount_str do
      key :type, :string
    end
    property :items do
      key :type, :array
      items do
        key :required, [:id_str, :href, :id, :name]
        property :id_str do
          key :type, :string
        end
        property :href do
          key :type, :string
        end
        property :id do
          key :type, :integer
          key :format, :int64
        end
        property :name do
          key :type, :string
        end
      end
    end
    property :pageCount do
      key :type, :integer
      key :format, :int64
    end
    property :pageCount_str do
      key :type, :string
    end
    property :totalCount do
      key :type, :integer
      key :format, :int64
    end
  end

  swagger_schema :OutputConstellation do
  end

  swagger_schema :OutputPlanetsList do
  end

  swagger_schema :OutputPlanet do
  end

  swagger_schema :OutputAlliancesList do
  end

  swagger_schema :OutputAlliance do
  end

  swagger_schema :OutputTypesList do
  end

  swagger_schema :OutputType do
  end

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
    tag do
      key :name, 'alliances'
      key :description, 'Alliances operations'
    end
    tag do
      key :name, 'constellations'
      key :description, 'Constellations operations'
    end
    tag do
      key :name, 'planets'
      key :description, 'Planets operations'
    end
    tag do
      key :name, 'types'
      key :description, 'Types operations'
    end
  end

  swagger_path '/constellations/' do
    operation :get do
      key :description, 'Get Constellations'
      key :tags, ['constellations']
      response 200 do
        key :description, 'Constellations list'
        schema do
          key :'$ref', :OutputConstellationsList
        end
      end
    end
  end

  swagger_path '/constellations/{constellation_id}/' do
    operation :get do
      key :description, 'Get Constellation'
      key :tags, ['constellations']
      parameter do
        key :name, 'constellation_id'
        key :in, :path
        key :description, 'Constellation ID'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'Constellation response'
        schema do
          key :'$ref', :OutputConstellation
        end
      end
    end
  end

  swagger_path '/planets/' do
    operation :get do
      key :description, 'Get Planets (Not Implemented)'
      key :tags, ['planets']
      response 200 do
        key :description, 'Planets list response'
        schema do
          key :'$ref', :OutputPlanetsList
        end
      end
    end
  end

  swagger_path '/planets/{planet_id}/' do
    operation :get do
      key :description, 'Get Planet info'
      key :tags, ['planets']
      parameter do
        key :name, 'planet_id'
        key :in, :path
        key :description, 'Planet ID'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'Planet response'
        schema do
          key :'$ref', :OutputPlanet
        end
      end
    end
  end

  swagger_path '/alliances/' do
    operation :get do
      key :description, 'Get Alliances'
      key :tags, ['alliances']
      response 200 do
        key :description, 'Alliances list response'
        schema do
          key :'$ref', :OutputAlliancesList
        end
      end
    end
  end

  swagger_path '/alliances/{alliance_id}/' do
    operation :get do
      key :description, 'Get Alliance'
      key :tags, ['alliances']
      parameter do
        key :name, 'alliance_id'
        key :in, :path
        key :description, 'Alliance ID'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'Alliance response'
        schema do
          key :'$ref', :OutputAlliance
        end
      end
    end
  end

  swagger_path '/types/' do
    operation :get do
      key :description, 'Get Types'
      key :tags, ['types']
      response 200 do
        key :description, 'Get Types list'
        schema do
          key :'$ref', :OutputTypesList
        end
      end
    end
  end

  swagger_path '/types/{type_id}/' do
    operation :get do
      key :description, 'Get Type info'
      key :tags, ['types']
      parameter do
        key :name, 'type_id'
        key :in, :path
        key :description, 'Type ID'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'Type response'
        schema do
          key :'$ref', :OutputType
        end
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
