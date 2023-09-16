module ApplicationHelper
  def embed_stamps_data_if_needed
    content_tag :script do
      raw "var stampsData = #{Stamp.all.map { |s| {id: s.id, name: s.name, latitude: s.latitude, longitude: s.longitude, sticker_url: s.sticker.url } }.to_json.html_safe};"
    end
  end
end
