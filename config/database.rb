configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

if development?
  set :database, {
    adapter: "sqlite3",
    database: "db/db.sqlite3"
  }
else
  set :database, ENV['DATABASE_URL']
end

  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end


# configure do
#   # Log queries to STDOUT in development
#   if Sinatra::Application.development?
#     ActiveRecord::Base.logger = Logger.new(STDOUT)
#   end

# if development?
#   set :database, {
#     adapter: "sqlite3",
#     database: "db/db.sqlite3"
#   }
# else
#   set :database, ENV['DATABASE_URL']
# end

# db = URI.parse('postgres://postgres:12345@localhost/contact_app')

# ActiveRecord::Base.establish_connection(
#   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
#   :host     => db.host,
#   :username => db.user,
#   :password => db.password,
#   :database => db.path[1..-1],
#   :encoding => 'utf8'
# )

#   # Load all models from app/models, using autoload instead of require
#   # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
#   Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
#     filename = File.basename(model_file).gsub('.rb', '')
#     autoload ActiveSupport::Inflector.camelize(filename), model_file
#   end

# end

