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



    def new?
        # If user role is editor or above(refer to User model)
        user.editor? || user.moderator? || user.admin?
    end

    def create?
        # If user role is editor or above(refer to User model)
        user.editor? || user.moderator? || user.admin?
    end

    def show?
        if post.restricted? && user.guest? || user.normal?
            return false    # Render the template for unsubscribed users
        else
            return true
        end
    end

    def edit?
        if user.editor? && post.owned_by?(user)
            return true
        elsif user.moderator? || user.admin?
            return true
        else
            return false
        end
    end

    def update?
        if user.editor? && post.owned_by?(user)
            return true
        elsif user.moderator? || user.admin?
            return true
        else
            return false
        end
    end

    def destroy?
        # If user role is moderator or above(refer to User model)
        user.moderator? || user.admin?
    end

end