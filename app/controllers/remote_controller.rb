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

  def create
    @u = User.find_by_uuid(request[:u])
    subject, content = request[:s], request[:c]
    
    @i = @u.items.build :subject => subject, :content => content
    status = @i.save ? 'saved' : 'failed'
    render 'debug_view'
    #render :text => "status: #{status}, ---content:|#{content}|, subject:|#{subject}|"
  end

  def bootstrap
    send_file 'public/javascripts/ktt_bootstrap.js', :type => 'application/javascript; charset=utf-8'
  end
end
