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
      sort = 'date_added'
      page = if !params['page'].blank? then params['page'].to_i else 1 end
      page_size = 500
      start = (page - 1) * page_size
      response = access_token.get("http://api.netflix.com/users/#{current_user.netflix_id}/queues/instant?output=json&sort=#{sort}&start_index=#{start}&max_results=#{page_size}").body
      @queue = MultiJson.decode(response)['queue']
      render 'member_index'
    end

  end

end
