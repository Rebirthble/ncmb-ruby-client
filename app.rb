$:.unshift(File.join(File.dirname(__FILE__), '.', 'lib'))
$:.unshift(File.dirname(__FILE__))
require 'ncmb'
require 'sinatra'
require 'json'
require 'yaml'

include NCMB
if File.exist?('./setting.yml')
    yaml = YAML.load_file(File.join(File.dirname(__FILE__), '.', 'setting.yml'))
    NCMB.initialize application_key: yaml['application_key'],  client_key: yaml['client_key']
else 
    NCMB.initialize application_key: "",  client_key: ""
end

##### for mesh_hack

get '/' do
  if File.exist?('./setting.yml')
    yaml = YAML.load_file(File.join(File.dirname(__FILE__), '.', 'setting.yml'))
  end
  @app_key = yaml['application_key']
  @client_key = yaml['client_key']
  erb :index
end

get '/classes/start_action' do
    hash = {:flag_value => 1}
    path = "/2013-09-01/classes/slot_start_flag/Gg8weX5ZoD7X8WVn"
    put_request(path, hash)
end

##### Routing

# object get
get '/classes/:class_name/:object_id' do
    path = "/2013-09-01/classes/#{params[:class_name]}/#{params[:object_id]}"
    get_request(path, {})
end

# object post
post '/classes/:class_name' do
    
    object = JSON.parse request.body.read
    path = "/2013-09-01/classes/#{params[:class_name]}"
    post_request(path, object)
end

# object put
put '/classes/:class_name/:object_id' do
    object = JSON.parse request.body.read
    path = "/2013-09-01/classes/#{params[:class_name]}/#{params[:object_id]}"
    put_request(path, object)
end

# object delete
delete '/classes/:class_name/:object_id' do
    path = "/2013-09-01/classes/#{params[:class_name]}/#{params[:object_id]}"
    delete_request(path, {})
end

# object search
get '/classes/:class_name' do
    path = "/2013-09-01/classes/#{params[:class_name]}"
    get_request(path, create_queries(params))
end

# push notification get
get '/push/:object_id' do
    path = "/2013-09-01/push/#{params[:object_id]}"
    get_request(path, {})
end

# push post
post '/push' do
    object = JSON.parse request.body.read
    path = "/2013-09-01/push"
    post_request(path, object)
end

# push put
put '/push/:object_id' do
    object = JSON.parse request.body.read
    path = "/2013-09-01/push/#{params[:object_id]}"
    put_request(path, object)
end

# push delete
delete '/push/:object_id' do
    path = "/2013-09-01/push/#{params[:object_id]}"
    delete_request(path, {})
end

# push search
get '/push' do
    path = "/2013-09-01/push"
    get_request(path, create_queries(params))
end

##### Function

# Request GET Method API
def get_request(url, queries)
    results = @@client.get url, queries
    results.to_json
end

# Request POST Method API
def post_request(url, object)
    results = @@client.post url, object
    results.to_json
end

# Request PUT Method API
def put_request(url, object)
    results = @@client.put url, object
    results.to_json
end

# Request DELETE Method API
def delete_request(url, queries)
    results = @@client.delete url, queries
    results.to_json
end

# Cerate Query for Search API
def create_queries(params)
    params.to_json
    queries = {}
    unless params[:where].nil?
        queries[:where] = params[:where]
    end
    [:limit, :count, :skip, :include, :order].each do |key|
        unless params[key].nil?
            queries[key] = params[key] 
        end
    end
    queries
end

