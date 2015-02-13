require "sinatra/json"

get '/' do
  @contacts = Contact.all.order('name')
  erb :index
end

post '/new' do
  contact = Contact.new({name: params[:name], email: params[:email], number: params[:number]})
 
  if contact.save
    json Contact.all.order('name')
  end
end

post '/delete' do
  contact = Contact.find(params[:id])
  Contact.destroy(contact.id)

  unless Contact.exists?(contact.id)
    json Contact.all.order('name')
  end
end

post '/post' do
  contact = Contact.find(params[:pk])
  contact.name = params[:value]
  contact.save
end




  