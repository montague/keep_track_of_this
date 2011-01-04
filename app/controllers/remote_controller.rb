class RemoteController < ApplicationController
  def home
    u = User.find_by_uuid(request[:uuid])
    if u.nil?
      render :text => "user not found"
    else
      if u.items.empty?
        render :text => "no items for this user"
      else
        data = {}
        u.items.each_with_index do |item, index| 
          data[:"item_#{index}"] = {:subject => item.subject, :content => item.content}
        end
        render :json => data
      end
    end
  end
end
