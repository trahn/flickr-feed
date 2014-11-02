module FlickrHelper
  def user_photos(user_id, photo_count = 12)
  	FlickRaw.api_key = File.read("config/flickr.yml").split[1]
  	FlickRaw.shared_secret = File.read("config/flickr.yml").split[3]
  	flickr.photos.search(:user_id => user_id).to_a.map(&:to_hash).values_at(0..(photo_count-1))
  end

  def render_flickr_sidebar_widget(user_id, photo_count = 90, columns = 6)
  	begin
  	  photos = user_photos(user_id, photo_count).in_groups_of(columns)
  	  render partial: 'flickr/sidebar_widget', locals: { photos: photos }
  	rescue Exception
  	  render partial: 'flickr/unavailable'
  	end
  end

  def url_s(photo)
  	"https://farm"+photo["farm"].to_s+".staticflickr.com/"+photo["server"]+"/"+photo["id"]+"_"+photo["secret"]+"_s.jpg"
  end

  def url_photopage(photo)
  	"https://www.flickr.com/photos/#{photo["owner"]}/#{photo["id"]}"
  end
end