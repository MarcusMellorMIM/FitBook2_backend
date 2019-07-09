class ApplicationController < ActionController::API

    def encode_token(payload)
        
        JWT.encode(payload, ENV['FITBOOK_SECRET'])
       
      end 
      
      def decode_token(token)
        # token => "eyJhbGciOiJIUzI1NiJ9.eyJiZWVmIjoic3RlYWsifQ._IBTHTLGX35ZJWTCcY30tLmwU9arwdpNVxtVU0NpAuI"
     
        JWT.decode(token, ENV['FITBOOK_SECRET'])[0]
        # JWT.decode => [{ "beef"=>"steak" }, { "alg"=>"HS256" }]
        # [0] gives us the payload { "beef"=>"steak" }
      end

      def get_token
        request.headers["Authorization"]
      end

      def current_user
        token = get_token
        decoded_token = decode_token(token)
        user = User.find(decoded_token["user_id"])
        user_hash = {
          username: user[:username],
          id: user[:id]
        }
      end
      
      def logged_in
        !!current_user
      end
    
    
end
