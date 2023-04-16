class PostCommentsController < ApplicationController

  def create
    post_image = PostImage.find(params[:post_image_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_image_id = post_image.id
    comment.save
    redirect_to post_image_path(post_image)

    # こう書いても良い
    # comment = PostComment.new(post_comment_params) #コメントインスタンスを作成
    # comment.user_id= current_user.id #idを設定
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_image_path(params[:post_image_id])
  end
  
  
  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
