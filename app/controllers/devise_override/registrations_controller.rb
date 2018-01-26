class DeviseOverride::RegistrationsController < Devise::RegistrationsController
    def create
      super # this calls Devise::RegistrationsController#create as usual
      # after creating a new user, create a profile that has
      # the profile.user_id field set to the user_id of the user jsut created
      if resource.save
          # @folder = Folder.new
          # @folder.user_id = resource.id
          # @folder.name = resource.username
          Folder.create(user_id: resource.id, name: resource.username)
          # @folder.save
          puts "\n\n\n\n\n\n#{resource.id}\n\n\n\n\n\n\n"
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