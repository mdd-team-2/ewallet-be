class JsonWebToken
  class << self
    def encode(playload: {}, exp: 2.days.from_now)
      playload[:exp] = exp.to_i
      JWT.encode(playload,"Esta llave es de prueba")
    end  
    def decode(token)
      body = JWT.decode(token,"Esta llave es de prueba")[0]
      HashWithIndifferentAccess.new body
    end
  end
end