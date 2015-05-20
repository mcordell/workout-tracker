class Exercise < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include CRUD

    model Exercise, :create

    builds ->(params) {
      throw(:warden) unless params[:current_user]
    }

    contract do
      property :display_name, validates: { presence: true }
    end

    def process(params)
      validate(params[:exercise]) do |f|
        f.save
      end
    end
  end

  class Update < Create
    action :update

    builds ->(params) {
      throw(:warden) unless params[:current_user]
    }
  end

  class Delete < Trailblazer::Operation
    builds ->(params) {
      throw(:warden) unless params[:current_user]
    }

    def process(params)
      Exercise.find(params[:id]).destroy
    end
  end
end
