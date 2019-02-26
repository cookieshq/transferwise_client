module TransferwiseClient
  # Quote request class
  class Request < Hash
    def path
      raise 'Path not implemented.'
    end

    def validation_params
      {}
    end
  end
end
