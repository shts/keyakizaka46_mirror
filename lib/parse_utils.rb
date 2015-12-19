# http://qiita.com/azusanakano/items/885fe3236977580b00c9
# Parseライブラリの読み込み
require 'parse-ruby-client'

class ParseUtils
  # TODO: Windowsのみで発生する証明書問題によりSSL認証エラーの暫定回避策
  # ENV['SSL_CERT_FILE'] = File.expand_path('C:\rumix\ruby\2.1\i386-mingw32\lib\ruby\2.1.0\rubygems\ssl_certs\cert.pem')
  Parse.init :application_id => ENV['PARSE_APP_ID'],
             :api_key        => ENV['PARSE_API_KEY']
  EntryClassName = "Entry"

  def get_entry(objectId)
    entry = Parse::Query.new(EntryClassName).tap do |q|
      q.eq("objectId", objectId)
    end.get.first
  end
end
