module ApplicationHelper
    def gravatar_for(user, options = { size: 80 })
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.username, class: 'img-circle')
    end
    
    def title(current_title="")
        base_title = "Alpha Blog"
        if current_title.blank?
            content_for :title, base_title
        else
            content_for :title, current_title + " | " + base_title
        end
    end
end
