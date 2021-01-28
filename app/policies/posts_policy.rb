class PostsPolicy
    attr_reader :user, :post

    def initialize(user, post = :empty)
        @post = post
        @user = user
    end

    def self.new?(user)
        new(user).new?
    end

    def self.create?(user, post)
        new(user, post).create?
    end

    def new?
        # If user role is editor or above(refer to User model)
        User.roles[user.role] > 1
    end

    def create?
        # If user role is editor or above(refer to User model)
        User.roles[user.role] > 1
    end
end