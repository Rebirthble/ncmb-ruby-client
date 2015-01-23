$:.unshift(File.join(File.dirname(__FILE__), '.', 'lib'))
$:.unshift(File.dirname(__FILE__))
require 'ncmb'
require 'sinatra'
require 'json'
require 'yaml'

include NCMB
yaml = YAML.load_file(File.join(File.dirname(__FILE__), '.', 'setting.yml'))
NCMB.initialize application_key: yaml['application_key'],  client_key: yaml['client_key']

# object get
get '/classes/:class_name/:object_id' do
    queries = {}
    path = "/2013-09-01/classes/#{params[:class_name]}/#{params[:object_id]}"
    results = @@client.get path, queries

    results.to_json
end

# object post
post '/classes/:class_name' do
    object = JSON.parse request.body.read
    path = "/2013-09-01/classes/#{params[:class_name]}"
    results = @@client.post path, object

    results.to_json
end

# object put
put '/classes/:class_name/:object_id' do
    path = "/2013-09-01/classes/#{params[:class_name]}/#{params[:object_id]}"
    results = @@client.put path, queries

    results.to_json
end

# object delete
delete '/classes/:class_name/:object_id' do
    queries = {}
    path = "/2013-09-01/classes/#{params[:class_name]}/#{params[:object_id]}"
    results = @@client.delete path, queries

    results.to_json
end

# object search
get '/classes/:class_name' do
    #hoge = Rack::Utils.parse_query(@env['rack.request.query_string'])
    #hoge.to_s
    queries = {}
    unless params[:where].nil?
        queries["where"] = params[:where]
    end
    [:limit, :count, :skip, :include, :order].each do |key|
        unless params[key].nil?
            queries[key] = params[key] 
        end
    end
    path = "/2013-09-01/classes/#{params[:class_name]}"
    results = @@client.get path, queries
    results.to_json
end
