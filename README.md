## TODO
- change sqlite3 to pg
- firebase
- sign out


GET    /organizations/:organization_id/organizations_users(.:format)     organizations_users#index
=> shows all users of the organization

POST   /organizations/:organization_id/organizations_users(.:format)     organizations_users#create
=> creates a new association between user and the organization

DELETE /organizations/:organization_id/organizations_users/:id(.:format) organizations_users#destroy
=> deletes an association between user and the organization

GET    /organizations(.:format)                                          organizations#index
=> shows all organizations to anyone(no login needed)

POST   /organizations(.:format)                                          organizations#create
=> allows admin to create a new organization

PUT    /organizations/:id(.:format)                                      organizations#update
=> i dont use it

DELETE /organizations/:id(.:format)                                      organizations#destroy
=> allows admin to delete an organization

POST   /auth/login(.:format)                                             authentication#authenticate
=> let user log in

POST   /signup(.:format)       
=> sign up a new user 