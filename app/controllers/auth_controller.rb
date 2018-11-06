class AuthController < ApplicationController
  skip_before_action :authorized, only: %i[create]

  def create
   user = User.find_by(username: params[:username])

   if user && user.authenticate(params[:password])
     token = issue_token({id: user.id})
     render json: {jwt: token}
   else
     render json: {error: 'User is invalid'}, status: 401
   end
 end

 def show
   token = request.headers["Authorization"].split(' ')[1]
   user_info = JWT.decode(token, 'secret', true, algorithm: 'HS256')
   user = User.find_by(id: user_info[0]["id"])
   if user
     render json: {username: user.username}
   else
     render json: {error: 'Invalid token'}, status: 401
   end
 end

end
