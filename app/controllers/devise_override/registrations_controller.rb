class DeviseOverride::RegistrationsController < Devise::RegistrationsController
    def create
      super # this calls Devise::RegistrationsController#create as usual
      # after creating a new user, create a profile that has
      # the profile.user_id field set to the user_id of the user jsut created
      if resource.save
          @folder = Folder.new
          @folder.user_id = resource.id
          @folder.name = resource.username
          @folder.save
      end
    end
  
    def destroy
      super
      if resource.destroy
          @folder = Folder.find(user_id: resource.id)
          @folder.destroy
      end
    end
  end