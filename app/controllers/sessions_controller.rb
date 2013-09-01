class SessionsController < ApplicationController
  def create
    data = request.env['omniauth.auth']
    User.find_or_create_by_provider_and_uid_and_name(:provider => data['provider'], :uid => data['uid'], :name => data['info']['name'])
    render :nothing => true
  end
end