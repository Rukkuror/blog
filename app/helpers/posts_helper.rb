module PostsHelper
  def blog_archive
    dates = Post.all.collect{|c| c.created_at.to_date.to_s}.map{|sd| Date.parse(sd)}
    @results = Hash[  dates.group_by(&:year).map{|y, items|
      [y, items.group_by{|d| d.strftime('%B')}]
    }]
    return @results
  end


  def convert_month_year(month,result)
     month = Date::MONTHNAMES.index(month).to_s
     year = result.to_s
     month_year =  "%"+year+"-"+sprintf('%02d',month)+"%"
     @posts = Post.where("created_at LIKE ? ", month_year)
     return @posts
  end

  def blog_label
    posts = Post.all
    tag_array = []
    posts.each do |post|
      tag_s =  post.tags
      tag_s.each do |c|
        tag_array << c.content
      end
    end
    @result_hash = tag_array.inject(Hash.new(0)){|h,k| k; h[k] += 1;h}
  end

end
