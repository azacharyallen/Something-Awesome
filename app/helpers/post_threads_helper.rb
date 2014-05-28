module PostThreadsHelper
  def lastReadLinkHelper(thread)
    last_read_post_id = @visits.where(post_thread_id: thread.id).first.post_id
    new_post_count = thread.posts.where("id > #{last_read_post_id}").count
    post_ids = thread.posts.pluck(:id).sort

    if new_post_count != 0 
      first_unread_post_id = post_ids[post_ids.index(last_read_post_id) + 1]
    else
      first_unread_post_id = last_read_post_id
    end 

    page = ((post_ids.index(first_unread_post_id) + 1) / 25.to_f).ceil
    query_string = "?page=#{page}#post-#{first_unread_post_id}"

    link = "<a href='" + post_thread_url(thread) + query_string + "' class='btn btn-sm btn-default'>" + new_post_count.to_s + " ></a>"
  end
end
