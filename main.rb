
require 'sinatra'
require 'pg'

require './db_config'
require './models/dish'
require './models/dish_type'
require './models/user'
require './models/like'


# configure :development do |c|
  require 'sinatra/reloader'
  require 'pry'
  # c.also_reload './models/*'
# end

enable :sessions

helpers do

  def logged_in?
    if current_user
      return true
    else
      return false
    end
    # alternatively use !!current_user - same meaning as above four lines
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

end

#method to avoid writing sql script every time
def run_sql(sql)
  db = PG.connect(dbname: 'goodfoodhunting')
  results = db.exec(sql)
  db.close
  return results
end

get '/dish_types' do
  @dish_types = DishType.all
   #write code here to print all from dish_types table
   erb :dishtypes
end

get '/' do
  # sql = "SELECT * FROM dish_types;"
  # @dish_types = run_sql(sql)

  @dish_types = DishType.all

  if params[:dish_type_id]
    # sql = "SELECT * FROM dishes WHERE dish_type_id = #{params[:dish_type_id]};"

    #AR version
    @dishes = Dish.where(dish_type_id: params[:dish_type_id])
  else
    # sql = "SELECT * FROM dishes;"
    # @dishes = run_sql(sql)

    #AR version
    @dishes = Dish.all #limit this to however many you want to show

  end

  @totallikes = Like.where(dish_id: 'params[:dish_id]}').count


  erb :index
end


#show the new dish form
get '/dishes/new' do
  # sql = "SELECT * FROM dish_types;"
  # @dish_types = run_sql(sql)

  @dish_types = DishType.all
  @dish = Dish.new

  erb :new
end


#show update dish form
get '/dishes/:id/edit' do
  # sql = "SELECT * FROM dish_types;"
  # @dish_types = run_sql(sql)

  @dish_types = DishType.all

  # sql = "SELECT * FROM dishes WHERE id = #{ params[:id] }"
  # #pg always returns a collection, hence the [0] below
  # @dish = run_sql(sql)[0]

  @dish = Dish.find(params[:id])

  erb :edit
end


#show single dish
get '/dishes/:id' do
  # sql = "SELECT * FROM dishes WHERE id = #{ params[:id] };"
  # @nameofdish = run_sql(sql)[0]

#AR version
  @dish = Dish.find(params[:id])
  erb :show
end


#create a dish
post '/dishes' do
  # if logged_in?

    # sql = "INSERT INTO dishes (name, image_url) values ('#{ params['name'] }','#{ params['image_url']}');"
    # run_sql(sql)

  # AR version
    @dish = Dish.new
    @dish.name = params[:name]
    @dish.image_url = params[:image_url]
    @dish.dish_type_id = params[:dish_type_id]

    if @dish.save
      redirect to '/'
    else
      @dish_types = DishType.all
      erb :new
    end
  # end
end


#create a like
post '/like' do
  like = Like.new
  like.user_id = current_user.id
  like.dish_id = params[:dish_id]
  like.save

  redirect to '/'

end


#edit a dish
patch '/dishes/:id' do
  # sql = "UPDATE dishes SET dish_type_id = '#{ params['dish_type_id'] }', name = '#{ params['name'] }', image_url = '#{ params['img_url'] }' WHERE id = #{ params[:id] };"
  #
  # run_sql(sql)

  dish = Dish.find(params[:id])

  dish.name = params[:name]
  dish.image_url = params[:image_url]
  dish.dish_type_id = params[:dish_type_id]
  dish.save

  redirect to "/dishes/#{ params[:id] }"
end

# see edit.erb for corresponding code
# using patch instead of post because post creates new input every time it is run


#delete a dish
delete '/dishes/:id' do
  # sql = "DELETE FROM dishes WHERE id = #{ params[:id] };"
  # run_sql(sql)

  dish = Dish.find(params[:id])
  dish.Destroy
  redirect to "/"
end

# authenticate

# show login form - we are creating a resource session
get '/session/new' do
  erb :login
end

# login page
post '/session' do
  # search for user
  user = User.find_by(email: params[:email])

  # authenticate password
  if user && user.authenticate(params[:password])
    # create session
    session[:user_id] = user.id  # see enable :sessions at top of page (part of Sinatra)
    # redirect elsewhere
    redirect to '/'
  else
    # stay on login
    erb :login
  end
end

# logout page
delete '/session' do
  session[:user_id] = nil
  redirect to '/session/new'
end

# test login details:
# email - example@somedomain.com
# password - pudding


#see show.erb bottom to see corresponding erb code
#use raise 'something' to raise an error to check routing
