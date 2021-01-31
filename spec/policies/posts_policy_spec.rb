require 'rails_helper'

RSpec.describe PostsPolicy do

    # User objects
    let(:admin) {
        User.new(
            email: "admin@test.com",
            password: "123456",
            password_confirmation: "123456",
            role: "admin"
        )
    }

    let(:moderator) {
        User.new(
            email: "moderator@test.com",
            password: "123456",
            password_confirmation: "123456",
            role: "moderator"
        )
    }

    let(:editor) {
        User.new(
            email: "editor@test.com",
            password: "123456",
            password_confirmation: "123456",
            role: "editor"
        )
    }

    let(:post_editor) {
        User.new(
            email: "post_editor@test.com",
            password: "123456",
            password_confirmation: "123456",
            role: "editor"
        )
    }

    let(:subscriber) {
        User.new(
            email: "subscriber@test.com",
            password: "123456",
            password_confirmation: "123456",
            role: "subscriber"
        )
    }

    let(:normal) {
        User.new(
            email: "normal@test.com",
            password: "123456",
            password_confirmation: "123456",
            role: "normal"
        )
    }

    # Post object
    let(:restricted_post) {
        Post.new(
            title: "Test post",
            content: "Test content",
            status: :restricted,
            user_id: post_editor.id
        )
    }


    describe '.new?' do
        it 'returns true if role is editor or above' do
            post_policy = PostsPolicy.new?(editor)
            expect( post_policy ).to eq(true)
	    end
    end

    describe '.create?' do
        it 'returns true if role is editor or above' do
            post_policy = PostsPolicy.create?(moderator)
            expect( post_policy ).to eq(true)
	    end
    end

    describe '.show?' do
        context 'when post has status restricted' do
            it 'returns false if user is guest or has :normal role' do
                post_policy = PostsPolicy.show?(normal, restricted_post)
                expect( post_policy ).to eq(false)
            end
        end

        it 'returns true if post status is published and/or role is subscriber or above' do
            post_policy = PostsPolicy.show?(editor, restricted_post)
            expect( post_policy ).to eq(true)
        end
    end

    describe '.edit?' do
        context 'when user role is editor' do
            it 'returns true if post belongs to the same editor' do
                post_policy = PostsPolicy.edit?(editor, restricted_post)
                expect( post_policy ).to eq(true)
            end

            it 'returns false if post does not belong to the same editor' do
                post_policy = PostsPolicy.edit?(editor, restricted_post)
                expect( post_policy ).to eq(false)
            end
        end

        context 'when user role is above editor' do
            it 'returns true' do
                post_policy = PostsPolicy.edit?(moderator, restricted_post)
                expect( post_policy ).to eq(true)
            end
        end
    end

end
