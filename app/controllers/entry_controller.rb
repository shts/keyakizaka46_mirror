
class EntryController < ApplicationController

  def show
    # http://www.rubylife.jp/rails/controller/index6.html
    # http://www.buildinsider.net/web/rubyonrails4/0202
    # http://www.stonedot.com/lecture5.html

    #render :text => ParseUtils.new.get_entry("#{params[:id]}")
    entry = ParseUtils.new.get_entry("#{params[:id]}")
    if entry == nil then
      puts "entry is nil"
      render :text => "記事が見つかりません"
      return
    end

    puts entry

    @kiji_yearmonth = entry['yearmonth']
    @kiji_day = "#{entry['day']}"
    @kiji_week = "#{entry['week']}"

    @kiji_member = "#{entry['author']}"
    @kiji_title = "#{entry['title']}"
    # http://qiita.com/satoken0417/items/7bcdb59eae82776375f9
    @kiji_body = entry['body'].html_safe
    # format 2015/12/03 00:21
    @kiji_foot = to_s(entry['published'])

    if !entry['image_url_list'].empty? then
      @image_url = entry['image_url_list'][0]
    end
    
    # http://keyakizaka46-mirror.herokuapp.com/entry/show/mqq7x6VukF
    @entry_url = "http://keyakizaka46-mirror.herokuapp.com/entry/show/#{entry['objectId']}"

    # http://snippets.feb19.jp/?p=1170
    ua = request.user_agent
    @isIOS = 0
    if ["iPhone", "iPad", "iPod"].find {|s| ua.include?(s) }
      @isIOS = 0 #TODO: iOSアプリの開発が完了したら1にする
    end
    @isAndroid = 0 # TODO
    if ["Android"].find {|s| ua.include?(s) }
      @isAndroid = 1
    end

  end

  private
  def to_s(published)
    month = published.month < 10 ? "0#{published.month}" : "#{published.month}"
    day = published.day < 10 ? "0#{published.day}" : "#{published.day}"
    hour = published.hour < 10 ? "0#{published.hour}" : "#{published.hour}"
    min = published.min < 10 ? "0#{published.min}" : "#{published.min}"
    "#{published.year}/#{month}/#{day} #{hour}:#{min}"
  end

end
