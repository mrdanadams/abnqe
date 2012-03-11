class HomeController < ApplicationController
  def index
    # TODO use a different layout if not logged in

    if user_signed_in?
      options = { :site => 'http://api.netflix.com' }
      consumer = OAuth::Consumer.new Settings.netflix.api_key, Settings.netflix.api_secret, options

      info = current_user.netflix_info
      access_token = OAuth::AccessToken.new consumer, info['token'], info['secret']

      # TODO get the link for the queues from the users account
      # TODO change page size to something bigger
      # TODO order by date added by default
      response = access_token.get("http://api.netflix.com/users/#{current_user.netflix_id}/queues/instant?output=json").body
      @queue = MultiJson.decode(response)['queue']
      render 'member_index'
    end


  end
end
