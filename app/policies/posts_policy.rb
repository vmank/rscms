class PostsPolicy
    attr_reader :user, :post

    def initialize(user, post = nil)
        @post = post
        @user = user
    end


    def self.show?(user, post)
        new(user, post).show?
    end

    def self.new?(user)
        new(user).new?
    end

    def self.create?(user)
        new(user).create?
    end

    def self.edit?(user, post)
        new(user, post).edit?
    end

    def self.update?(user, post)
        new(user, post).update?
    end

    def self.destroy?(user)
        new(user).destroy?
    end



    def new?
        # If user role is editor or above(refer to User model)
        user.try(:editor?) || user.try(:moderator?) || user.try(:admin?)
    end

    def create?
        # If user role is editor or above(refer to User model)
        user.try(:editor?) || user.try(:moderator?) || user.try(:admin?)
    end

    def show?
        if post.try(:restricted?) && user.try(:guest?) || user.try(:normal?)
            return false    # Render the template for unsubscribed users
        else
            return true
        end
    end

    def edit?
        if user.try(:editor?) && post.try(:owned_by?, user)
            return true
        elsif user.try(:moderator?) || user.try(:admin?)
            return true
        else
            return false
        end
    end

    def update?
        if user.try(:editor?) && post.try(:owned_by?, user)
            return true
        elsif user.try(:moderator?) || user.try(:admin?)
            return true
        else
            return false
        end
    end

    def destroy?
        # If user role is moderator or above(refer to User model)
        user.try(:moderator?) || user.try(:admin?)
    end

end