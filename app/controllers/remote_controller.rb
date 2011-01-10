class RemoteController < ApplicationController
  
  #get
  def show
    u = User.find_by_uuid(request[:uuid])
    if u.nil?
      render :text => "user not found\n"
    else
      if u.items.empty?
        render :text => "no items for this user"
      else
        data = []
        u.items.each_with_index do |item, index| 
          data << {:subject => item.subject, :content => item.content}
        end
        render :json => data
      end
    end
  end

  #post
  def create
    render :text => "hi mom!!"
  end

  # def bootstrap
  #     headers['Content-type'] = 'text/javascript'
  #     render :file => "#{RAILS_ROOT}/public/javascripts/ktot_bootstrap.js?#{Time.now.strftime('%s%L')}"
  #   end
  end
