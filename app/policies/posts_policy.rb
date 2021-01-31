class PostsPolicy
    attr_reader :user, :post

    def initialize(user, post = :empty)
        @post = post
        @user = user
    end


    def self.new?(user)
        new(user).new?
    end

    def self.create?(user)
        new(user).create?
    end

    def self.show?(user, post)
        new(user, post).show?
    end


    def new?
        # If user role is editor or above(refer to User model)
        User.roles[user.role] > 1
    end

    def create?
        # If user role is editor or above(refer to User model)
        User.roles[user.role] > 1
    end

    def show?
        if post.restricted? && ( user.guest? || user.normal? )
            return false    # Render the template for unsubscribed users
        else
            return true
        end
    end


end