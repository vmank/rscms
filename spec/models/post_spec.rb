require 'rails_helper'

RSpec.describe Post, type: :model do


	subject {
		Post.new(
			:title => 'Test post title',
			:content => 'Test post content',
			:status => :published,
		)
	}

	it 'is invalid without attributes' do
		expect( Post.new ).to be_invalid
	end

	it 'is invalid without title' do
		expect( Post.new( :title => "Test post title" ) ).to be_invalid
	end

	it 'is invalid without title' do
		expect( Post.new( :content => "Test post content" ) ).to be_invalid
	end

	it 'has pending status if no status is passed' do
		expect( Post.new( :title => "Test post title", :content => "Test post content" ).status ).to eq( "pending" )
	end

	it 'has given status if status is passed' do
		expect( subject.status ).to eq( "published" )
	end

end
