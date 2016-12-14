module PostsHelper

  def average_star(post)
    stars_array = []
    if post.stars.length != 0
      @full_star = (post.stars.map { |s| s.count }.sum / post.stars.length.to_f).round
      @full_star.times do
        stars_array.push(fa_icon("star"))
      end
      (5 - @full_star).times do
        stars_array.push(fa_icon("star-o"))
      end
    else
      5.times do
        stars_array.push(fa_icon("star-o"))
      end
    end
    stars_array.join.html_safe
  end

  def display_star(post)

    if post.stars.find_by(user: current_user).nil?
      star = 0
      star_count = 0
    else
      star = post.stars.find_by(user: current_user)
      star_count = star.count
    end
    blank = star_count + 1

    method = (
      if star == 0
        :post
      else
        :patch
      end
    )

    def path(post, star, count)
      if star == 0
        post_stars_path(post, star: { count: count })
      else
        star_path(star, star: { count: count })
      end
    end

    links = []

    1.upto(star_count) do |i|
      links << link_to(fa_icon('star'), path(post, star, i),remote: true, method: method)
    end

    blank.upto(5) do |i|
      links << link_to(fa_icon('star-o'), path(post, star, i), remote: true,  method: method)
    end

    raw "<div class=\"stars_button\">#{safe_join(links, ' ')}</div>"
  end
end
