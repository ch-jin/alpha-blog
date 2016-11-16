module ApplicationHelper
    def gravatar_for(user, options = { size: 80 })
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.username, class: 'img-circle')
    end
    
    def title(*args)
        base_title = "Alpha Blog"
        if args[0]
            content_for :title, args[0].to_s + " | " + base_title
        else
            content_for :title, base_title
        end
    end
end
