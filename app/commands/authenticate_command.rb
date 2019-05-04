class AuthenticateCommand
  prepend SimpleCommand
  attr_accessor :email,:password,:type,:id

  def initialize(email,password)
    @email = email
    @password = password
  end

  def call
    if find
      JsonWebToken.encode(playload: {id: find.id,type: find.role.id}) 
    end
  end

  private
  def find
    
    find = User.by_email(@email)
  
    return find if find && find.authenticate(@password)
    errors.add :authentication, 'invalid credentials'
    nil
  end
end