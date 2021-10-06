class PostsController < ApplicationController

    before_action :logged_in_usr, only: [:create]

    def create
        @tournament = Tournament.find(params[:id])
        @participant = @tournament.participants.find(user: current_user)
        @post = @participant.posts.build(post_params)
	if @post.save
	    # if PostAction.where(user: current_user).exists?
	    #     PostAction.find_by(user: current_user).destroy
	    # end
	    # PostAction.create!(post: @post, user: current_user)
        if RecentAction.where(user: current_user).exists?
            RecentAction.find_by(user: current_user).destroy
        end
        unless RecentAction.new(action: 1, user: current_user, tournament: @tournament).save
            flash[:debug] = "failed to recent action."
            redirect_to root_url
        end
        flash.now[:success] = "投稿しました"
        redirect_to tournament_path
    else
        flash[:danger] = "投稿に失敗しました"
    end

end
